import 'package:cloud_firestore/cloud_firestore.dart';

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
    this.sortOrder = 0,
    this.isEnabled = true,
  });

  final int sortOrder;
  final bool isEnabled;

  factory SubscriptionPackageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data() ?? <String, dynamic>{};

    return SubscriptionPackageModel(
      id: snapshot.id,
      titleKey: data['titleKey'] as String? ?? '',
      subtitleKey: data['subtitleKey'] as String? ?? '',
      descriptionKey: data['descriptionKey'] as String? ?? '',
      priceLabel: data['priceLabel'] as String? ?? '',
      billingCycleKey: data['billingCycleKey'] as String? ?? '',
      featureKeys: (data['featureKeys'] as List<dynamic>? ?? const <dynamic>[])
          .whereType<String>()
          .toList(growable: false),
      durationDays: (data['durationDays'] as num?)?.toInt() ?? 0,
      isPopular: data['isPopular'] as bool? ?? false,
      sortOrder: (data['sortOrder'] as num?)?.toInt() ?? 0,
      isEnabled: data['isEnabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'titleKey': titleKey,
      'subtitleKey': subtitleKey,
      'descriptionKey': descriptionKey,
      'priceLabel': priceLabel,
      'billingCycleKey': billingCycleKey,
      'featureKeys': featureKeys,
      'durationDays': durationDays,
      'isPopular': isPopular,
      'sortOrder': sortOrder,
      'isEnabled': isEnabled,
    };
  }
}
