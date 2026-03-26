import 'package:get/get.dart';

import '../../features/subscription/presentation/views/purchase_history_page.dart';
import '../../features/subscription/presentation/views/purchase_package_page.dart';
import 'app_routes.dart';

abstract final class AppPages {
  static final pages = <GetPage<void>>[
    GetPage<void>(
      name: AppRoutes.purchasePackages,
      page: PurchasePackagePage.new,
    ),
    GetPage<void>(
      name: AppRoutes.purchaseHistory,
      page: PurchaseHistoryPage.new,
    ),
  ];
}
