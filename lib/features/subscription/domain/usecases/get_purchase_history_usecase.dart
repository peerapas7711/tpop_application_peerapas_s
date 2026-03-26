import '../entities/purchase_history_snapshot.dart';
import '../repositories/subscription_repository.dart';

class GetPurchaseHistoryUseCase {
  const GetPurchaseHistoryUseCase(this._repository);

  final SubscriptionRepository _repository;

  Future<PurchaseHistorySnapshot> call() {
    return _repository.getPurchaseHistory();
  }
}
