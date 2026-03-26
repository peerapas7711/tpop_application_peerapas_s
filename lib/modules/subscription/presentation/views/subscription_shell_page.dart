import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/utils/constants/app_colors.dart';
import '../controllers/subscription_shell_controller.dart';
import '../widgets/subscription_page_scaffold.dart';
import 'purchase_history_page.dart';
import 'purchase_package_page.dart';
import 'subscription_settings_page.dart';

class SubscriptionShellPage extends StatefulWidget {
  const SubscriptionShellPage({
    super.key,
    this.initialTab = SubscriptionBottomTab.packages,
  });

  final SubscriptionBottomTab initialTab;

  @override
  State<SubscriptionShellPage> createState() => _SubscriptionShellPageState();
}

class _SubscriptionShellPageState extends State<SubscriptionShellPage> {
  late final SubscriptionShellController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<SubscriptionShellController>();
    _controller.attachShell(widget.initialTab);
  }

  @override
  void dispose() {
    _controller.detachShell();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentTab = _controller.currentTab.value;

      return SubscriptionPageScaffold(
        titleKey: currentTab.titleKey,
        body: IndexedStack(
          index: currentTab.index,
          children: const [
            PurchasePackagePage(embedded: true),
            PurchaseHistoryPage(embedded: true),
            SubscriptionSettingsPage(embedded: true),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentTab.index,
          backgroundColor: Colors.white,
          indicatorColor: AppColors.roseTint,
          onDestinationSelected: _controller.goToIndex,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.sell_outlined),
              selectedIcon: const Icon(Icons.sell_rounded),
              label: 'subscriptionTabPackages'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.history_outlined),
              selectedIcon: const Icon(Icons.history_rounded),
              label: 'subscriptionTabHistory'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings_rounded),
              label: 'subscriptionTabSettings'.tr,
            ),
          ],
        ),
      );
    });
  }
}
