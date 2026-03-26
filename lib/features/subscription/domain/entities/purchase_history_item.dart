enum PurchaseStatus { active, expired }

class PurchaseHistoryItem {
  const PurchaseHistoryItem({
    required this.id,
    required this.packageId,
    required this.packageTitleKey,
    required this.packageSubtitleKey,
    required this.priceLabel,
    required this.purchasedAt,
    required this.startAt,
    required this.endAt,
    required this.paymentMethodKey,
    required this.status,
  });

  final String id;
  final String packageId;
  final String packageTitleKey;
  final String packageSubtitleKey;
  final String priceLabel;
  final DateTime purchasedAt;
  final DateTime startAt;
  final DateTime endAt;
  final String paymentMethodKey;
  final PurchaseStatus status;

  bool get isActive => status == PurchaseStatus.active;
}
