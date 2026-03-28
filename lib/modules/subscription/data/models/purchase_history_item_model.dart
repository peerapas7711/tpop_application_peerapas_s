import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory PurchaseHistoryItemModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data() ?? <String, dynamic>{};

    return PurchaseHistoryItemModel(
      id: snapshot.id,
      packageId: data['packageId'] as String? ?? '',
      packageTitleKey: data['packageTitleKey'] as String? ?? '',
      packageSubtitleKey: data['packageSubtitleKey'] as String? ?? '',
      priceLabel: data['priceLabel'] as String? ?? '',
      purchasedAt: _readDate(data['purchasedAt']),
      startAt: _readDate(data['startAt']),
      endAt: _readDate(data['endAt']),
      paymentMethodKey: data['paymentMethodKey'] as String? ?? '',
      status: _readStatus(data['status'] as String?),
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'packageId': packageId,
      'packageTitleKey': packageTitleKey,
      'packageSubtitleKey': packageSubtitleKey,
      'priceLabel': priceLabel,
      'purchasedAt': Timestamp.fromDate(purchasedAt),
      'startAt': Timestamp.fromDate(startAt),
      'endAt': Timestamp.fromDate(endAt),
      'paymentMethodKey': paymentMethodKey,
      'status': _writeStatus(status),
    };
  }

  static DateTime _readDate(dynamic rawValue) {
    if (rawValue is Timestamp) {
      return rawValue.toDate();
    }

    if (rawValue is DateTime) {
      return rawValue;
    }

    if (rawValue is String) {
      return DateTime.tryParse(rawValue) ??
          DateTime.fromMillisecondsSinceEpoch(0);
    }

    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  static PurchaseStatus _readStatus(String? value) {
    switch (value) {
      case 'active':
        return PurchaseStatus.active;
      case 'expired':
      default:
        return PurchaseStatus.expired;
    }
  }

  static String _writeStatus(PurchaseStatus status) {
    switch (status) {
      case PurchaseStatus.active:
        return 'active';
      case PurchaseStatus.expired:
        return 'expired';
    }
  }
}
