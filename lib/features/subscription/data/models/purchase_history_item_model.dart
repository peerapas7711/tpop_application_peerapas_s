import '../../domain/entities/purchase_history_item.dart';

class PurchaseHistoryItemModel extends PurchaseHistoryItem {
  const PurchaseHistoryItemModel({
    required super.id,
    required super.packageId,
    required super.packageTitleKey,
    required super.packageSubtitleKey,
    required super.priceLabel,
    required super.purchasedAt,
    required super.startAt,
    required super.endAt,
    required super.paymentMethodKey,
    required super.status,
  });

  PurchaseHistoryItemModel copyWith({
    String? id,
    String? packageId,
    String? packageTitleKey,
    String? packageSubtitleKey,
    String? priceLabel,
    DateTime? purchasedAt,
    DateTime? startAt,
    DateTime? endAt,
    String? paymentMethodKey,
    PurchaseStatus? status,
  }) {
    return PurchaseHistoryItemModel(
      id: id ?? this.id,
      packageId: packageId ?? this.packageId,
      packageTitleKey: packageTitleKey ?? this.packageTitleKey,
      packageSubtitleKey: packageSubtitleKey ?? this.packageSubtitleKey,
      priceLabel: priceLabel ?? this.priceLabel,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      paymentMethodKey: paymentMethodKey ?? this.paymentMethodKey,
      status: status ?? this.status,
    );
  }
}
