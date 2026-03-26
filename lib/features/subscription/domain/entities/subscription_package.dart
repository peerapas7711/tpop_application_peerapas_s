class SubscriptionPackage {
  const SubscriptionPackage({
    required this.id,
    required this.titleKey,
    required this.subtitleKey,
    required this.descriptionKey,
    required this.priceLabel,
    required this.billingCycleKey,
    required this.featureKeys,
    required this.durationDays,
    this.isPopular = false,
  });

  final String id;
  final String titleKey;
  final String subtitleKey;
  final String descriptionKey;
  final String priceLabel;
  final String billingCycleKey;
  final List<String> featureKeys;
  final int durationDays;
  final bool isPopular;
}
