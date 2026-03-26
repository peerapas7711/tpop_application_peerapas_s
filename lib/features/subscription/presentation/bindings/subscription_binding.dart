import 'package:get/get.dart';

import '../../../../core/config/app_environment.dart';
import '../../data/datasources/subscription_mock_datasource.dart';
import '../../data/repositories/subscription_repository_impl.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../../domain/usecases/get_purchase_history_usecase.dart';
import '../../domain/usecases/get_subscription_packages_usecase.dart';
import '../../domain/usecases/purchase_subscription_package_usecase.dart';
import '../controllers/purchase_history_controller.dart';
import '../controllers/purchase_package_controller.dart';

class SubscriptionBinding extends Bindings {
  SubscriptionBinding(this.environment);

  final AppEnvironment environment;

  @override
  void dependencies() {
    Get.lazyPut<AppEnvironment>(() => environment, fenix: true);
    Get.lazyPut<SubscriptionMockDatasource>(
      () => SubscriptionMockDatasource(Get.find<AppEnvironment>()),
      fenix: true,
    );
    Get.lazyPut<SubscriptionRepository>(
      () => SubscriptionRepositoryImpl(Get.find<SubscriptionMockDatasource>()),
      fenix: true,
    );
    Get.lazyPut<GetSubscriptionPackagesUseCase>(
      () => GetSubscriptionPackagesUseCase(Get.find<SubscriptionRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetPurchaseHistoryUseCase>(
      () => GetPurchaseHistoryUseCase(Get.find<SubscriptionRepository>()),
      fenix: true,
    );
    Get.lazyPut<PurchaseSubscriptionPackageUseCase>(
      () => PurchaseSubscriptionPackageUseCase(
        Get.find<SubscriptionRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<PurchasePackageController>(
      () => PurchasePackageController(
        environment: Get.find<AppEnvironment>(),
        getPackagesUseCase: Get.find<GetSubscriptionPackagesUseCase>(),
        purchaseUseCase: Get.find<PurchaseSubscriptionPackageUseCase>(),
      ),
      fenix: true,
    );
    Get.lazyPut<PurchaseHistoryController>(
      () => PurchaseHistoryController(
        environment: Get.find<AppEnvironment>(),
        getPurchaseHistoryUseCase: Get.find<GetPurchaseHistoryUseCase>(),
      ),
      fenix: true,
    );
  }
}
