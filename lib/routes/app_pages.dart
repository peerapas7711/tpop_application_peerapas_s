import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/modules/subscription/presentation/controllers/subscription_shell_controller.dart';
import 'package:tpop_application_peerapas_s/modules/subscription/presentation/views/subscription_shell_page.dart';
import 'app_routes.dart';

abstract final class AppPages {
  static final pages = <GetPage<void>>[
    GetPage<void>(
      name: AppRoutes.subscription,
      page: SubscriptionShellPage.new,
    ),
    GetPage<void>(
      name: AppRoutes.purchasePackages,
      page:
          () => const SubscriptionShellPage(
            initialTab: SubscriptionBottomTab.packages,
          ),
    ),
    GetPage<void>(
      name: AppRoutes.purchaseHistory,
      page:
          () => const SubscriptionShellPage(
            initialTab: SubscriptionBottomTab.history,
          ),
    ),
    GetPage<void>(
      name: AppRoutes.settings,
      page:
          () => const SubscriptionShellPage(
            initialTab: SubscriptionBottomTab.settings,
          ),
    ),
  ];
}
