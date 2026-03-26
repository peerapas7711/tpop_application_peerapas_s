import '../entities/subscription_package.dart';
import '../repositories/subscription_repository.dart';

class GetSubscriptionPackagesUseCase {
  const GetSubscriptionPackagesUseCase(this._repository);

  final SubscriptionRepository _repository;

  Future<List<SubscriptionPackage>> call() {
    return _repository.getAvailablePackages();
  }
}
