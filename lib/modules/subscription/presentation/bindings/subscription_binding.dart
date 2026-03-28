import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/app_environment.dart';
import '../../data/datasources/subscription_firestore_datasource.dart';
import '../../data/repositories/subscription_repository_impl.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../../domain/usecases/clear_purchase_history_usecase.dart';
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
    Bind.lazyPut<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
      fenix: true,
    ),
    Bind.lazyPut<SubscriptionFirestoreDatasource>(
      () => SubscriptionFirestoreDatasource(
        Get.find<FirebaseFirestore>(),
        Get.find<AppEnvironment>(),
      ),
      fenix: true,
    ),
    Bind.lazyPut<SubscriptionRepository>(
      () => SubscriptionRepositoryImpl(
        Get.find<SubscriptionFirestoreDatasource>(),
      ),
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
    Bind.lazyPut<ClearPurchaseHistoryUseCase>(
      () => ClearPurchaseHistoryUseCase(Get.find<SubscriptionRepository>()),
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
      () => SubscriptionSettingsController(
        clearPurchaseHistoryUseCase: Get.find<ClearPurchaseHistoryUseCase>(),
      ),
      fenix: true,
    ),
  ];
}
