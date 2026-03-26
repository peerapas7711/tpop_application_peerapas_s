import '../../domain/entities/subscription_package.dart';

class SubscriptionPackageModel extends SubscriptionPackage {
  const SubscriptionPackageModel({
    required super.id,
    required super.titleKey,
    required super.subtitleKey,
    required super.descriptionKey,
    required super.priceLabel,
    required super.billingCycleKey,
    required super.featureKeys,
    required super.durationDays,
    super.isPopular,
  });
}
