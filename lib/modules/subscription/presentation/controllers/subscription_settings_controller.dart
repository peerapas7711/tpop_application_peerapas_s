import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tpop_application_peerapas_s/service/app_storage.dart';
import 'package:tpop_application_peerapas_s/utils/constants/app_colors.dart';
import 'package:tpop_application_peerapas_s/utils/lang/app_translations.dart';

import '../../domain/usecases/clear_purchase_history_usecase.dart';
import 'purchase_history_controller.dart';

class SubscriptionSettingsController extends GetxController {
  SubscriptionSettingsController({
    required ClearPurchaseHistoryUseCase clearPurchaseHistoryUseCase,
  }) : _clearPurchaseHistoryUseCase = clearPurchaseHistoryUseCase;

  static const _languageSwitchLoadingDuration = Duration(milliseconds: 450);

  final ClearPurchaseHistoryUseCase _clearPurchaseHistoryUseCase;
  final RxString selectedLanguageCode =
      AppTranslations.fallbackLocale.languageCode.obs;
  final RxString changingLanguageCode = ''.obs;
  final RxString appVersion = ''.obs;
  final RxBool isUpdatingLanguage = false.obs;
  final RxBool isLoadingVersion = true.obs;
  final RxBool isClearingHistory = false.obs;

  @override
  void onInit() {
    super.onInit();
    syncSelectedLanguage();
    loadAppVersion();
  }

  Future<void> loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      appVersion.value = 'v${packageInfo.version} (${packageInfo.buildNumber})';
    } catch (_) {
      appVersion.value = '';
    } finally {
      isLoadingVersion.value = false;
    }
  }

  Future<void> updateLanguage(Locale locale) async {
    final nextLanguageCode = locale.languageCode;
    final sameLanguage = selectedLanguageCode.value == nextLanguageCode;

    if (isUpdatingLanguage.value || (sameLanguage && Get.locale == locale)) {
      return;
    }

    isUpdatingLanguage.value = true;
    changingLanguageCode.value = nextLanguageCode;

    try {
      await AppStorage.instance.writeLocale(locale);
      await Future<void>.delayed(_languageSwitchLoadingDuration);

      if (!sameLanguage || Get.locale != locale) {
        await Get.updateLocale(locale);
      }

      selectedLanguageCode.value = nextLanguageCode;
    } finally {
      changingLanguageCode.value = '';
      isUpdatingLanguage.value = false;
    }
  }

  void syncSelectedLanguage() {
    final locale =
        AppStorage.instance.readLocale() ??
        Get.locale ??
        AppTranslations.fallbackLocale;
    selectedLanguageCode.value = locale.languageCode;
  }

  Future<void> clearPurchaseHistory() async {
    if (isClearingHistory.value) {
      return;
    }

    isClearingHistory.value = true;

    try {
      await _clearPurchaseHistoryUseCase.call();

      if (Get.isRegistered<PurchaseHistoryController>()) {
        await Get.find<PurchaseHistoryController>().loadHistory(
          showLoading: false,
        );
      }

      Get.snackbar(
        'subscriptionSettingsClearHistorySuccessTitle'.tr,
        'subscriptionSettingsClearHistorySuccessMessage'.tr,
        backgroundColor: AppColors.success,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
        margin: const EdgeInsets.all(16),
      );
    } catch (_) {
      Get.snackbar(
        'commonErrorTitle'.tr,
        'subscriptionSettingsClearHistoryErrorMessage'.tr,
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isClearingHistory.value = false;
    }
  }
}
