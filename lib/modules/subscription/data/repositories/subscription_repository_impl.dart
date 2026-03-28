import '../../domain/entities/purchase_history_item.dart';
import '../../domain/entities/purchase_history_snapshot.dart';
import '../../domain/entities/subscription_package.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/subscription_firestore_datasource.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  const SubscriptionRepositoryImpl(this._datasource);

  final SubscriptionFirestoreDatasource _datasource;

  @override
  Future<List<SubscriptionPackage>> getAvailablePackages() {
    return _datasource.getPackages();
  }

  @override
  Future<PurchaseHistorySnapshot> getPurchaseHistory() {
    return _datasource.getPurchaseHistory();
  }

  @override
  Future<PurchaseHistoryItem> purchasePackage(String packageId) {
    return _datasource.purchasePackage(packageId);
  }

  @override
  Future<void> clearPurchaseHistory() {
    return _datasource.clearPurchaseHistory();
  }
}
