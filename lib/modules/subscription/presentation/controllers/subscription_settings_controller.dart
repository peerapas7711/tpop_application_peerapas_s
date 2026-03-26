import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tpop_application_peerapas_s/service/app_storage.dart';
import 'package:tpop_application_peerapas_s/utils/lang/app_translations.dart';

class SubscriptionSettingsController extends GetxController {
  static const _languageSwitchLoadingDuration = Duration(milliseconds: 450);

  final RxString selectedLanguageCode =
      AppTranslations.fallbackLocale.languageCode.obs;
  final RxString changingLanguageCode = ''.obs;
  final RxString appVersion = ''.obs;
  final RxBool isUpdatingLanguage = false.obs;
  final RxBool isLoadingVersion = true.obs;

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
}
