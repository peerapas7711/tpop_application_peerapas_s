import '../entities/purchase_history_item.dart';
import '../entities/purchase_history_snapshot.dart';
import '../entities/subscription_package.dart';

abstract class SubscriptionRepository {
  Future<List<SubscriptionPackage>> getAvailablePackages();
  Future<PurchaseHistorySnapshot> getPurchaseHistory();
  Future<PurchaseHistoryItem> purchasePackage(String packageId);
}
