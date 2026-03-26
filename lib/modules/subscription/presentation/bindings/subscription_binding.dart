import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/app_environment.dart';
import '../../data/datasources/subscription_mock_datasource.dart';
import '../../data/repositories/subscription_repository_impl.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../../domain/usecases/get_purchase_history_usecase.dart';
import '../../domain/usecases/get_subscription_packages_usecase.dart';
import '../../domain/usecases/purchase_subscription_package_usecase.dart';
import '../controllers/purchase_history_controller.dart';
import '../controllers/purchase_package_controller.dart';
import '../controllers/subscription_shell_controller.dart';
import '../controllers/subscription_settings_controller.dart';

class SubscriptionBinding extends Binding {
  SubscriptionBinding(this.environment);

  final AppEnvironment environment;

  @override
  List<Bind> dependencies() => [
    Bind.lazyPut<AppEnvironment>(() => environment, fenix: true),
    Bind.lazyPut<SubscriptionMockDatasource>(
      () => SubscriptionMockDatasource(Get.find<AppEnvironment>()),
      fenix: true,
    ),
    Bind.lazyPut<SubscriptionRepository>(
      () => SubscriptionRepositoryImpl(Get.find<SubscriptionMockDatasource>()),
      fenix: true,
    ),
    Bind.lazyPut<GetSubscriptionPackagesUseCase>(
      () => GetSubscriptionPackagesUseCase(Get.find<SubscriptionRepository>()),
      fenix: true,
    ),
    Bind.lazyPut<GetPurchaseHistoryUseCase>(
      () => GetPurchaseHistoryUseCase(Get.find<SubscriptionRepository>()),
      fenix: true,
    ),
    Bind.lazyPut<PurchaseSubscriptionPackageUseCase>(
      () => PurchaseSubscriptionPackageUseCase(
        Get.find<SubscriptionRepository>(),
      ),
      fenix: true,
    ),
    Bind.lazyPut<SubscriptionShellController>(
      SubscriptionShellController.new,
      fenix: true,
    ),
    Bind.lazyPut<PurchasePackageController>(
      () => PurchasePackageController(
        getPackagesUseCase: Get.find<GetSubscriptionPackagesUseCase>(),
        purchaseUseCase: Get.find<PurchaseSubscriptionPackageUseCase>(),
      ),
      fenix: true,
    ),
    Bind.lazyPut<PurchaseHistoryController>(
      () => PurchaseHistoryController(
        getPurchaseHistoryUseCase: Get.find<GetPurchaseHistoryUseCase>(),
      ),
      fenix: true,
    ),
    Bind.lazyPut<SubscriptionSettingsController>(
      SubscriptionSettingsController.new,
      fenix: true,
    ),
  ];
}
