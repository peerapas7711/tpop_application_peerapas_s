import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tpop_application_peerapas_s/app_environment.dart';
import 'package:tpop_application_peerapas_s/firebase_options.dart';
import 'package:tpop_application_peerapas_s/modules/subscription/presentation/bindings/subscription_binding.dart';
import 'package:tpop_application_peerapas_s/routes/app_pages.dart';
import 'package:tpop_application_peerapas_s/routes/app_routes.dart';
import 'package:tpop_application_peerapas_s/service/app_storage.dart';
import 'package:tpop_application_peerapas_s/utils/constants/app_colors.dart';
import 'package:tpop_application_peerapas_s/utils/lang/app_translations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final environment = AppEnvironment.fromDefines();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppStorage.instance.init();

  runApp(SubscriptionApp(environment: environment));
}

class SubscriptionApp extends StatelessWidget {
  const SubscriptionApp({super.key, required this.environment});

  final AppEnvironment environment;

  @override
  Widget build(BuildContext context) {
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    final storedLocale = AppStorage.instance.readLocale();

    return GetMaterialApp(
      title: environment.appName,
      debugShowCheckedModeBanner: false,
      theme: _buildAppTheme(),
      binds: SubscriptionBinding(environment).dependencies(),
      initialRoute: AppRoutes.subscription,
      getPages: AppPages.pages,
      translations: AppTranslations(),
      locale: storedLocale ?? AppTranslations.resolveLocale(deviceLocale),
      fallbackLocale: AppTranslations.fallbackLocale,
      supportedLocales: AppTranslations.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}

ThemeData _buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primaryRose,
    brightness: Brightness.light,
  ).copyWith(
    primary: AppColors.primaryRose,
    onPrimary: Colors.white,
    secondary: AppColors.primaryRoseDark,
    surface: Colors.white,
    onSurface: AppColors.textPrimary,
    outline: AppColors.border,
    error: AppColors.danger,
  );
  final textTheme = GoogleFonts.promptTextTheme(
    const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.15,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
        height: 1.45,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
        height: 1.45,
      ),
      labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
    ),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    fontFamily: GoogleFonts.prompt().fontFamily,
    scaffoldBackgroundColor: AppColors.canvas,
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.textPrimary,
      contentTextStyle: GoogleFonts.prompt(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimary,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: AppColors.card,
      shadowColor: AppColors.primaryRose.withValues(alpha: 0.08),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: EdgeInsets.zero,
    ),
    dividerColor: AppColors.border,
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primaryRose,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(54),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryRoseDark,
        side: const BorderSide(color: AppColors.border),
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.roseTint,
      selectedColor: AppColors.primaryRose,
      secondarySelectedColor: AppColors.primaryRose,
      labelStyle: const TextStyle(
        color: AppColors.primaryRoseDark,
        fontWeight: FontWeight.w600,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
    ),
  );
}
