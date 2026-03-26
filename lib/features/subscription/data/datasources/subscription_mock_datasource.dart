import '../../../../core/config/app_environment.dart';
import '../../domain/entities/purchase_history_item.dart';
import '../../domain/entities/purchase_history_snapshot.dart';
import '../models/purchase_history_item_model.dart';
import '../models/subscription_package_model.dart';

class SubscriptionMockDatasource {
  SubscriptionMockDatasource(this._environment)
    : _packages = _buildPackages(),
      _history = _buildInitialHistory();

  final AppEnvironment _environment;
  final List<SubscriptionPackageModel> _packages;
  final List<PurchaseHistoryItemModel> _history;

  Future<List<SubscriptionPackageModel>> getPackages() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));

    switch (_environment.packagesState) {
      case MockDataState.empty:
        return const <SubscriptionPackageModel>[];
      case MockDataState.error:
        throw Exception('subscription-packages-error');
      case MockDataState.success:
        return List<SubscriptionPackageModel>.unmodifiable(_packages);
    }
  }

  Future<PurchaseHistorySnapshot> getPurchaseHistory() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));

    switch (_environment.historyState) {
      case MockDataState.empty:
        return const PurchaseHistorySnapshot(
          activePackages: <PurchaseHistoryItem>[],
          expiredPackages: <PurchaseHistoryItem>[],
        );
      case MockDataState.error:
        throw Exception('subscription-history-error');
      case MockDataState.success:
        final active =
            _history.where((item) => item.isActive).toList()
              ..sort((a, b) => b.purchasedAt.compareTo(a.purchasedAt));
        final expired =
            _history.where((item) => !item.isActive).toList()
              ..sort((a, b) => b.endAt.compareTo(a.endAt));

        return PurchaseHistorySnapshot(
          activePackages: active,
          expiredPackages: expired,
        );
    }
  }

  Future<PurchaseHistoryItemModel> purchasePackage(String packageId) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));

    SubscriptionPackageModel? selectedPackage;
    for (final package in _packages) {
      if (package.id == packageId) {
        selectedPackage = package;
        break;
      }
    }

    if (selectedPackage == null) {
      throw Exception('package-not-found');
    }

    final now = DateTime.now();
    final expiredActivePackages =
        _history
            .where((item) => item.isActive)
            .map(
              (item) =>
                  item.copyWith(endAt: now, status: PurchaseStatus.expired),
            )
            .toList();

    _history
      ..removeWhere((item) => item.isActive)
      ..addAll(expiredActivePackages);

    final purchase = PurchaseHistoryItemModel(
      id: '${selectedPackage.id}-${now.microsecondsSinceEpoch}',
      packageId: selectedPackage.id,
      packageTitleKey: selectedPackage.titleKey,
      packageSubtitleKey: selectedPackage.subtitleKey,
      priceLabel: selectedPackage.priceLabel,
      purchasedAt: now,
      startAt: now,
      endAt: now.add(Duration(days: selectedPackage.durationDays)),
      paymentMethodKey: _resolvePaymentMethod(selectedPackage.id),
      status: PurchaseStatus.active,
    );

    _history.insert(0, purchase);
    return purchase;
  }

  static List<SubscriptionPackageModel> _buildPackages() {
    return const <SubscriptionPackageModel>[
      SubscriptionPackageModel(
        id: 'pink_plus',
        titleKey: 'packagePinkPlusTitle',
        subtitleKey: 'packagePinkPlusSubtitle',
        descriptionKey: 'packagePinkPlusDescription',
        priceLabel: 'THB 149',
        billingCycleKey: 'subscriptionPerMonth',
        featureKeys: <String>[
          'packagePinkPlusFeature1',
          'packagePinkPlusFeature2',
          'packagePinkPlusFeature3',
          'packagePinkPlusFeature4',
        ],
        durationDays: 30,
      ),
      SubscriptionPackageModel(
        id: 'stage_pass',
        titleKey: 'packageStagePassTitle',
        subtitleKey: 'packageStagePassSubtitle',
        descriptionKey: 'packageStagePassDescription',
        priceLabel: 'THB 1,290',
        billingCycleKey: 'subscriptionPerYear',
        featureKeys: <String>[
          'packageStagePassFeature1',
          'packageStagePassFeature2',
          'packageStagePassFeature3',
          'packageStagePassFeature4',
        ],
        durationDays: 365,
        isPopular: true,
      ),
    ];
  }

  static List<PurchaseHistoryItemModel> _buildInitialHistory() {
    final now = DateTime.now();

    return <PurchaseHistoryItemModel>[
      PurchaseHistoryItemModel(
        id: 'active-stage-pass',
        packageId: 'stage_pass',
        packageTitleKey: 'packageStagePassTitle',
        packageSubtitleKey: 'packageStagePassSubtitle',
        priceLabel: 'THB 1,290',
        purchasedAt: now.subtract(const Duration(days: 18)),
        startAt: now.subtract(const Duration(days: 18)),
        endAt: now.add(const Duration(days: 347)),
        paymentMethodKey: 'paymentApplePay',
        status: PurchaseStatus.active,
      ),
      PurchaseHistoryItemModel(
        id: 'expired-pink-plus-01',
        packageId: 'pink_plus',
        packageTitleKey: 'packagePinkPlusTitle',
        packageSubtitleKey: 'packagePinkPlusSubtitle',
        priceLabel: 'THB 149',
        purchasedAt: now.subtract(const Duration(days: 58)),
        startAt: now.subtract(const Duration(days: 58)),
        endAt: now.subtract(const Duration(days: 28)),
        paymentMethodKey: 'paymentGooglePlay',
        status: PurchaseStatus.expired,
      ),
      PurchaseHistoryItemModel(
        id: 'expired-pink-plus-02',
        packageId: 'pink_plus',
        packageTitleKey: 'packagePinkPlusTitle',
        packageSubtitleKey: 'packagePinkPlusSubtitle',
        priceLabel: 'THB 149',
        purchasedAt: now.subtract(const Duration(days: 92)),
        startAt: now.subtract(const Duration(days: 92)),
        endAt: now.subtract(const Duration(days: 62)),
        paymentMethodKey: 'paymentCreditCard',
        status: PurchaseStatus.expired,
      ),
    ];
  }

  String _resolvePaymentMethod(String packageId) {
    switch (packageId) {
      case 'stage_pass':
        return 'paymentApplePay';
      case 'pink_plus':
      default:
        return 'paymentCreditCard';
    }
  }
}
