import 'purchase_history_item.dart';

class PurchaseHistorySnapshot {
  const PurchaseHistorySnapshot({
    required this.activePackages,
    required this.expiredPackages,
  });

  final List<PurchaseHistoryItem> activePackages;
  final List<PurchaseHistoryItem> expiredPackages;

  bool get isEmpty => activePackages.isEmpty && expiredPackages.isEmpty;
}
