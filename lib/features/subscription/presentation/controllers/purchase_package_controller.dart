import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/config/app_environment.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/subscription_package.dart';
import '../../domain/usecases/get_subscription_packages_usecase.dart';
import '../../domain/usecases/purchase_subscription_package_usecase.dart';
import 'purchase_history_controller.dart';

class PurchasePackageController extends GetxController
    with StateMixin<List<SubscriptionPackage>> {
  PurchasePackageController({
    required AppEnvironment environment,
    required GetSubscriptionPackagesUseCase getPackagesUseCase,
    required PurchaseSubscriptionPackageUseCase purchaseUseCase,
  }) : _environment = environment,
       _getPackagesUseCase = getPackagesUseCase,
       _purchaseUseCase = purchaseUseCase;

  final AppEnvironment _environment;
  final GetSubscriptionPackagesUseCase _getPackagesUseCase;
  final PurchaseSubscriptionPackageUseCase _purchaseUseCase;

  final RxnString selectedPackageId = RxnString();
  final RxBool isPurchasing = false.obs;

  AppEnvironment get environment => _environment;
  List<SubscriptionPackage> get packages =>
      state ?? const <SubscriptionPackage>[];

  SubscriptionPackage? get selectedPackage {
    final selectedId = selectedPackageId.value;
    for (final package in packages) {
      if (package.id == selectedId) {
        return package;
      }
    }

    return packages.isNotEmpty ? packages.first : null;
  }

  @override
  void onInit() {
    super.onInit();
    loadPackages();
  }

  Future<void> loadPackages() async {
    change(null, status: RxStatus.loading());

    try {
      final packages = await _getPackagesUseCase.call();
      if (packages.isEmpty) {
        change(const <SubscriptionPackage>[], status: RxStatus.empty());
        return;
      }

      selectedPackageId.value ??= packages.first.id;
      change(packages, status: RxStatus.success());
    } catch (_) {
      change(null, status: RxStatus.error('subscriptionPurchaseErrorTitle'));
    }
  }

  void selectPackage(String packageId) {
    selectedPackageId.value = packageId;
  }

  Future<void> purchaseSelectedPackage() async {
    final package = selectedPackage;
    if (package == null || isPurchasing.value) {
      return;
    }

    isPurchasing.value = true;

    try {
      await _purchaseUseCase.call(package.id);
      await Get.find<PurchaseHistoryController>().loadHistory(
        showLoading: false,
      );
      Get.snackbar(
        'subscriptionPurchaseSuccessTitle'.tr,
        'subscriptionPurchaseSuccessMessage'.tr,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      await Get.toNamed(AppRoutes.purchaseHistory);
    } catch (_) {
      Get.snackbar(
        'commonErrorTitle'.tr,
        'subscriptionPurchaseErrorMessage'.tr,
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isPurchasing.value = false;
    }
  }
}
