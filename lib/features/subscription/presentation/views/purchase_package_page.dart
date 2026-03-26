import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/environment_badge.dart';
import '../../../../core/widgets/state_cards.dart';
import '../controllers/purchase_package_controller.dart';
import '../widgets/package_plan_card.dart';
import '../widgets/purchase_summary_card.dart';
import '../widgets/subscription_loading_view.dart';
import '../widgets/subscription_page_scaffold.dart';

class PurchasePackagePage extends GetView<PurchasePackageController> {
  const PurchasePackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubscriptionPageScaffold(
      titleKey: 'subscriptionPurchaseTitle',
      showHistoryShortcut: true,
      body: controller.obx(
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
      ),
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
                                _PurchaseHero(controller: controller),
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
                          _PurchaseHero(controller: controller),
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
  const _PurchaseHero({required this.controller});

  final PurchasePackageController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final environment = controller.environment;

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD8E5), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EnvironmentBadge(environment: environment),
            const SizedBox(height: 18),
            Text(
              'subscriptionPurchaseHeadline'.tr,
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'subscriptionPurchaseSubtitle'.tr,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'subscriptionReadyTitle'.tr,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'subscriptionReadySubtitle'.tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(
                    label: 'commonFirebaseProject'.tr,
                    value: environment.firebaseConfig.projectId,
                  ),
                  const SizedBox(height: 10),
                  _InfoRow(label: 'API', value: environment.apiBaseUrl),
                ],
              ),
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(label, style: theme.textTheme.bodyMedium),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
