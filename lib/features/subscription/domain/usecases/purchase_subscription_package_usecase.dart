import '../entities/purchase_history_item.dart';
import '../repositories/subscription_repository.dart';

class PurchaseSubscriptionPackageUseCase {
  const PurchaseSubscriptionPackageUseCase(this._repository);

  final SubscriptionRepository _repository;

  Future<PurchaseHistoryItem> call(String packageId) {
    return _repository.purchasePackage(packageId);
  }
}
