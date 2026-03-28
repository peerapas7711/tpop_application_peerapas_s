import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/routes/app_routes.dart';
import 'package:tpop_application_peerapas_s/utils/constants/app_colors.dart';
import '../../domain/entities/subscription_package.dart';
import '../../domain/usecases/get_subscription_packages_usecase.dart';
import '../../domain/usecases/purchase_subscription_package_usecase.dart';
import 'purchase_history_controller.dart';
import 'subscription_shell_controller.dart';

class PurchasePackageController extends GetxController
    with StateMixin<List<SubscriptionPackage>> {
  PurchasePackageController({
    required GetSubscriptionPackagesUseCase getPackagesUseCase,
    required PurchaseSubscriptionPackageUseCase purchaseUseCase,
  }) : _getPackagesUseCase = getPackagesUseCase,
       _purchaseUseCase = purchaseUseCase;

  final GetSubscriptionPackagesUseCase _getPackagesUseCase;
  final PurchaseSubscriptionPackageUseCase _purchaseUseCase;

  final RxnString selectedPackageId = RxnString();
  final RxBool isPurchasing = false.obs;

  List<SubscriptionPackage> get packages =>
      status.isSuccess ? state : const <SubscriptionPackage>[];

  SubscriptionPackage? get selectedPackage {
    final selectedId = selectedPackageId.value;
    if (selectedId == null) {
      return null;
    }

    for (final package in packages) {
      if (package.id == selectedId) {
        return package;
      }
    }

    return null;
  }

  @override
  void onInit() {
    super.onInit();
    loadPackages();
  }

  Future<void> loadPackages() async {
    change(GetStatus<List<SubscriptionPackage>>.loading());

    try {
      final packages = await _getPackagesUseCase.call();
      if (packages.isEmpty) {
        selectedPackageId.value = null;
        change(GetStatus<List<SubscriptionPackage>>.empty());
        return;
      }

      if (!_containsPackage(packages, selectedPackageId.value)) {
        selectedPackageId.value = packages.first.id;
      }

      change(GetStatus<List<SubscriptionPackage>>.success(packages));
    } catch (_) {
      change(
        GetStatus<List<SubscriptionPackage>>.error(
          'subscriptionPurchaseErrorTitle',
        ),
      );
    }
  }

  void selectPackage(String packageId) {
    selectedPackageId.value = packageId;
  }

  bool _containsPackage(List<SubscriptionPackage> packages, String? packageId) {
    if (packageId == null) {
      return false;
    }

    for (final package in packages) {
      if (package.id == packageId) {
        return true;
      }
    }

    return false;
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
        snackPosition: SnackPosition.bottom,
        margin: const EdgeInsets.all(16),
      );

      final shellController = Get.find<SubscriptionShellController>();
      if (shellController.hasActiveShell) {
        shellController.goToTab(SubscriptionBottomTab.history);
      } else {
        await Get.offNamed(AppRoutes.purchaseHistory);
      }
    } catch (_) {
      Get.snackbar(
        'commonErrorTitle'.tr,
        'subscriptionPurchaseErrorMessage'.tr,
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isPurchasing.value = false;
    }
  }
}
