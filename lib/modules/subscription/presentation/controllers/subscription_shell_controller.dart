import 'package:get/get.dart';

enum SubscriptionBottomTab { packages, history, settings }

extension SubscriptionBottomTabX on SubscriptionBottomTab {
  String get titleKey {
    switch (this) {
      case SubscriptionBottomTab.packages:
        return 'subscriptionPurchaseTitle';
      case SubscriptionBottomTab.history:
        return 'subscriptionHistoryTitle';
      case SubscriptionBottomTab.settings:
        return 'subscriptionSettingsTitle';
    }
  }
}

class SubscriptionShellController extends GetxController {
  final Rx<SubscriptionBottomTab> currentTab =
      SubscriptionBottomTab.packages.obs;
  final RxBool isShellAttached = false.obs;

  bool get hasActiveShell => isShellAttached.value;

  void attachShell(SubscriptionBottomTab initialTab) {
    isShellAttached.value = true;
    currentTab.value = initialTab;
  }

  void detachShell() {
    isShellAttached.value = false;
  }

  void goToIndex(int index) {
    currentTab.value = SubscriptionBottomTab.values[index];
  }

  void goToTab(SubscriptionBottomTab tab) {
    currentTab.value = tab;
  }
}
