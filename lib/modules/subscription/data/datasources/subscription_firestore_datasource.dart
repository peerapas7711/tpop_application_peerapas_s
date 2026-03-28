import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tpop_application_peerapas_s/app_environment.dart';

import '../../domain/entities/purchase_history_item.dart';
import '../../domain/entities/purchase_history_snapshot.dart';
import '../models/purchase_history_item_model.dart';
import '../models/subscription_package_model.dart';
import 'subscription_seed_catalog.dart';

class SubscriptionFirestoreDatasource {
  SubscriptionFirestoreDatasource(this._firestore, this._environment);

  static const int _deleteBatchSize = 400;

  final FirebaseFirestore _firestore;
  final AppEnvironment _environment;

  // Each app environment writes to its own branch so staging and prod data
  // can coexist safely even when they share the same Firebase project.
  CollectionReference<Map<String, dynamic>> get _packagesCollection =>
      _environmentRoot.collection('subscription_packages');

  CollectionReference<Map<String, dynamic>> get _purchaseHistoryCollection =>
      _environmentRoot.collection('subscription_purchases');

  DocumentReference<Map<String, dynamic>> get _environmentRoot => _firestore
      .collection('environments')
      .doc(_environment.firestoreEnvironmentKey);

  Future<List<SubscriptionPackageModel>> getPackages() async {
    await _seedMissingPackages();

    final snapshot = await _packagesCollection.get();
    final packages =
        snapshot.docs
            .map(SubscriptionPackageModel.fromFirestore)
            .where((package) => package.isEnabled)
            .toList()
          ..sort((left, right) => left.sortOrder.compareTo(right.sortOrder));

    return List<SubscriptionPackageModel>.unmodifiable(packages);
  }

  Future<PurchaseHistorySnapshot> getPurchaseHistory() async {
    final snapshot = await _purchaseHistoryCollection.get();
    final history =
        snapshot.docs.map(PurchaseHistoryItemModel.fromFirestore).toList();

    final active =
        history.where((item) => item.isActive).toList()..sort(
          (left, right) => right.purchasedAt.compareTo(left.purchasedAt),
        );
    final expired =
        history.where((item) => !item.isActive).toList()
          ..sort((left, right) => right.endAt.compareTo(left.endAt));

    return PurchaseHistorySnapshot(
      activePackages: List<PurchaseHistoryItem>.unmodifiable(active),
      expiredPackages: List<PurchaseHistoryItem>.unmodifiable(expired),
    );
  }

  Future<PurchaseHistoryItemModel> purchasePackage(String packageId) async {
    final packageSnapshot = await _packagesCollection.doc(packageId).get();
    if (!packageSnapshot.exists) {
      throw Exception('package-not-found');
    }

    final package = SubscriptionPackageModel.fromFirestore(packageSnapshot);
    if (!package.isEnabled) {
      throw Exception('package-disabled');
    }

    final now = DateTime.now();
    final activePurchases =
        await _purchaseHistoryCollection
            .where('status', isEqualTo: 'active')
            .get();

    final batch = _firestore.batch();
    for (final activePurchase in activePurchases.docs) {
      batch.update(activePurchase.reference, <String, dynamic>{
        'endAt': Timestamp.fromDate(now),
        'status': 'expired',
      });
    }

    final newPurchaseReference = _purchaseHistoryCollection.doc();
    final purchase = PurchaseHistoryItemModel(
      id: newPurchaseReference.id,
      packageId: package.id,
      packageTitleKey: package.titleKey,
      packageSubtitleKey: package.subtitleKey,
      priceLabel: package.priceLabel,
      purchasedAt: now,
      startAt: now,
      endAt: now.add(Duration(days: package.durationDays)),
      paymentMethodKey: resolveSubscriptionPaymentMethod(package.id),
      status: PurchaseStatus.active,
    );

    batch.set(newPurchaseReference, purchase.toFirestore());
    await batch.commit();

    return purchase;
  }

  Future<void> clearPurchaseHistory() async {
    while (true) {
      final snapshot =
          await _purchaseHistoryCollection.limit(_deleteBatchSize).get();

      if (snapshot.docs.isEmpty) {
        return;
      }

      final batch = _firestore.batch();
      for (final purchase in snapshot.docs) {
        batch.delete(purchase.reference);
      }

      await batch.commit();

      if (snapshot.docs.length < _deleteBatchSize) {
        return;
      }
    }
  }

  Future<void> _seedMissingPackages() async {
    final existingPackages = await _packagesCollection.get();
    final existingPackageIds =
        existingPackages.docs.map((doc) => doc.id).toSet();
    final missingPackages = kDefaultSubscriptionPackages
        .where((package) => !existingPackageIds.contains(package.id))
        .toList(growable: false);

    if (missingPackages.isEmpty) {
      return;
    }

    final batch = _firestore.batch();
    for (final package in missingPackages) {
      batch.set(_packagesCollection.doc(package.id), package.toFirestore());
    }

    await batch.commit();
  }
}
