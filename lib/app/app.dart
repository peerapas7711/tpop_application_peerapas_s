import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../core/config/app_environment.dart';
import '../features/subscription/presentation/bindings/subscription_binding.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'translations/app_translations.dart';

class SubscriptionApp extends StatelessWidget {
  const SubscriptionApp({super.key, required this.environment});

  final AppEnvironment environment;

  @override
  Widget build(BuildContext context) {
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;

    return GetMaterialApp(
      title: environment.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(environment),
      initialBinding: SubscriptionBinding(environment),
      initialRoute: AppRoutes.purchasePackages,
      getPages: AppPages.pages,
      translations: AppTranslations(),
      locale: AppTranslations.resolveLocale(deviceLocale),
      fallbackLocale: AppTranslations.fallbackLocale,
      supportedLocales: AppTranslations.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
