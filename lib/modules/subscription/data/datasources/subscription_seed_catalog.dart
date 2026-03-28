import '../models/subscription_package_model.dart';

const List<SubscriptionPackageModel> kDefaultSubscriptionPackages =
    <SubscriptionPackageModel>[
      SubscriptionPackageModel(
        id: 'pink_lite',
        titleKey: 'packagePinkLiteTitle',
        subtitleKey: 'packagePinkLiteSubtitle',
        descriptionKey: 'packagePinkLiteDescription',
        priceLabel: 'THB 79',
        billingCycleKey: 'subscriptionPerMonth',
        featureKeys: <String>[
          'packagePinkLiteFeature1',
          'packagePinkLiteFeature2',
          'packagePinkLiteFeature3',
          'packagePinkLiteFeature4',
        ],
        durationDays: 30,
        sortOrder: 1,
      ),
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
        sortOrder: 2,
      ),
      SubscriptionPackageModel(
        id: 'fan_club',
        titleKey: 'packageFanClubTitle',
        subtitleKey: 'packageFanClubSubtitle',
        descriptionKey: 'packageFanClubDescription',
        priceLabel: 'THB 249',
        billingCycleKey: 'subscriptionPerMonth',
        featureKeys: <String>[
          'packageFanClubFeature1',
          'packageFanClubFeature2',
          'packageFanClubFeature3',
          'packageFanClubFeature4',
        ],
        durationDays: 30,
        sortOrder: 3,
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
        sortOrder: 4,
      ),
      SubscriptionPackageModel(
        id: 'backstage_vip',
        titleKey: 'packageBackstageVipTitle',
        subtitleKey: 'packageBackstageVipSubtitle',
        descriptionKey: 'packageBackstageVipDescription',
        priceLabel: 'THB 2,490',
        billingCycleKey: 'subscriptionPerYear',
        featureKeys: <String>[
          'packageBackstageVipFeature1',
          'packageBackstageVipFeature2',
          'packageBackstageVipFeature3',
          'packageBackstageVipFeature4',
        ],
        durationDays: 365,
        sortOrder: 5,
      ),
    ];

String resolveSubscriptionPaymentMethod(String packageId) {
  switch (packageId) {
    case 'pink_lite':
      return 'paymentGooglePlay';
    case 'stage_pass':
    case 'backstage_vip':
      return 'paymentApplePay';
    case 'fan_club':
    case 'pink_plus':
    default:
      return 'paymentCreditCard';
  }
}
