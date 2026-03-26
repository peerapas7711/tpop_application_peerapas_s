import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/widgets/state_cards.dart';
import '../controllers/purchase_package_controller.dart';
import '../widgets/package_plan_card.dart';
import '../widgets/purchase_summary_card.dart';
import '../widgets/subscription_loading_view.dart';
import '../widgets/subscription_page_scaffold.dart';

class PurchasePackagePage extends GetView<PurchasePackageController> {
  const PurchasePackagePage({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final body = controller.obx(
      (_) => RefreshIndicator(
        onRefresh: controller.loadPackages,
        child: _PurchaseContent(controller: controller),
      ),
      onLoading: const SubscriptionLoadingView(recordCount: 2),
      onEmpty: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: StateMessageCard(
            icon: Icons.inbox_outlined,
            titleKey: 'subscriptionEmptyTitle',
            descriptionKey: 'subscriptionEmptyDescription',
            actionLabelKey: 'commonRetry',
            onPressed: controller.loadPackages,
          ),
        ),
      ),
      onError:
          (_) => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: StateMessageCard(
                icon: Icons.cloud_off_rounded,
                titleKey: 'subscriptionPurchaseErrorTitle',
                descriptionKey: 'subscriptionPurchaseErrorDescription',
                actionLabelKey: 'commonRetry',
                onPressed: controller.loadPackages,
              ),
            ),
          ),
    );

    if (embedded) {
      return body;
    }

    return SubscriptionPageScaffold(
      titleKey: 'subscriptionPurchaseTitle',
      body: body,
    );
  }
}

class _PurchaseContent extends StatelessWidget {
  const _PurchaseContent({required this.controller});

  final PurchasePackageController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 960;

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1120),
              child:
                  wide
                      ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                const _PurchaseHero(),
                                const SizedBox(height: 18),
                                Obx(() {
                                  final selectedPackage =
                                      controller.selectedPackage;
                                  if (selectedPackage == null) {
                                    return const SizedBox.shrink();
                                  }

                                  return PurchaseSummaryCard(
                                    package: selectedPackage,
                                    isPurchasing: controller.isPurchasing.value,
                                    onPressed:
                                        controller.purchaseSelectedPackage,
                                  );
                                }),
                              ],
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            flex: 6,
                            child: _PackageList(controller: controller),
                          ),
                        ],
                      )
                      : Column(
                        children: [
                          const _PurchaseHero(),
                          const SizedBox(height: 18),
                          _PackageList(controller: controller),
                          const SizedBox(height: 18),
                          Obx(() {
                            final selectedPackage = controller.selectedPackage;
                            if (selectedPackage == null) {
                              return const SizedBox.shrink();
                            }

                            return PurchaseSummaryCard(
                              package: selectedPackage,
                              isPurchasing: controller.isPurchasing.value,
                              onPressed: controller.purchaseSelectedPackage,
                            );
                          }),
                        ],
                      ),
            ),
          ),
        );
      },
    );
  }
}

class _PurchaseHero extends StatelessWidget {
  const _PurchaseHero();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'subscriptionPurchaseHeadline'.tr,
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'subscriptionPurchaseSubtitle'.tr,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _PackageList extends StatelessWidget {
  const _PackageList({required this.controller});

  final PurchasePackageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedPackageId = controller.selectedPackageId.value;
      return Column(
        children: [
          for (final package in controller.packages) ...[
            PackagePlanCard(
              package: package,
              selected: selectedPackageId == package.id,
              onSelect: () => controller.selectPackage(package.id),
            ),
            const SizedBox(height: 18),
          ],
        ],
      );
    });
  }
}
