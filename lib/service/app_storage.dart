import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tpop_application_peerapas_s/utils/constants/tags.dart';

class AppStorage {
  AppStorage._();

  static final AppStorage instance = AppStorage._();

  late final GetStorage _box;
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await GetStorage.init(tagsStorageName);
    _box = GetStorage(tagsStorageName);
    _initialized = true;
  }

  Locale? readLocale() {
    final storedLocale = readString(Tags.LOCALE);
    if (storedLocale != null && storedLocale.isNotEmpty) {
      return _parseLocale(storedLocale);
    }

    final storedLanguage = readString(Tags.LOCALELANG) ?? readString(Tags.LANG);
    if (storedLanguage != null && storedLanguage.isNotEmpty) {
      return Locale(storedLanguage);
    }

    return null;
  }

  String? readString(String key) {
    if (!_initialized) {
      return null;
    }

    return _box.read<String>(key);
  }

  Future<void> writeLocale(Locale locale) async {
    await _ensureInitialized();

    final localeString =
        locale.countryCode == null || locale.countryCode!.isEmpty
            ? locale.languageCode
            : '${locale.languageCode}_${locale.countryCode}';

    await _box.write(Tags.LANG, locale.languageCode);
    await _box.write(Tags.LOCALELANG, locale.languageCode);
    await _box.write(Tags.LOCALE, localeString);
    await _box.write(Tags.LOCALE_LABEL, _resolveLocaleLabel(locale));
  }

  Future<void> clear() async {
    await _ensureInitialized();
    await _box.erase();
  }

  Future<void> _ensureInitialized() async {
    if (_initialized) {
      return;
    }

    await init();
  }

  Locale _parseLocale(String rawLocale) {
    final separator = rawLocale.contains('_') ? '_' : '-';
    final parts = rawLocale.split(separator);

    if (parts.length >= 2) {
      return Locale(parts[0], parts[1]);
    }

    return Locale(parts.first);
  }

  String _resolveLocaleLabel(Locale locale) {
    switch (locale.languageCode) {
      case 'th':
        return 'ไทย';
      case 'en':
      default:
        return 'English';
    }
  }
}
