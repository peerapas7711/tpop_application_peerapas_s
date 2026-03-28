import '../repositories/subscription_repository.dart';

class ClearPurchaseHistoryUseCase {
  const ClearPurchaseHistoryUseCase(this._repository);

  final SubscriptionRepository _repository;

  Future<void> call() {
    return _repository.clearPurchaseHistory();
  }
}
