import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/routes/app_routes.dart';
import 'package:tpop_application_peerapas_s/utils/constants/app_colors.dart';
import 'package:tpop_application_peerapas_s/widgets/state_cards.dart';
import '../../domain/entities/purchase_history_item.dart';
import '../../domain/entities/purchase_history_snapshot.dart';
import '../controllers/purchase_history_controller.dart';
import '../controllers/subscription_shell_controller.dart';
import '../widgets/history_record_card.dart';
import '../widgets/subscription_loading_view.dart';
import '../widgets/subscription_page_scaffold.dart';

class PurchaseHistoryPage extends GetView<PurchaseHistoryController> {
  const PurchaseHistoryPage({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final body = controller.obx(
      (history) => RefreshIndicator(
        onRefresh: () => controller.loadHistory(),
        child: _HistoryContent(history: history),
      ),
      onLoading: const SubscriptionLoadingView(
        recordCount: 2,
        includeSidebar: false,
      ),
      onEmpty: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: StateMessageCard(
            icon: Icons.receipt_long_outlined,
            titleKey: 'subscriptionHistoryEmptyTitle',
            descriptionKey: 'subscriptionHistoryEmptyDescription',
            actionLabelKey: 'commonBrowsePlans',
            onPressed: () {
              final shellController = Get.find<SubscriptionShellController>();
              if (shellController.hasActiveShell) {
                shellController.goToTab(SubscriptionBottomTab.packages);
                return;
              }

              Get.offNamed(AppRoutes.purchasePackages);
            },
          ),
        ),
      ),
      onError:
          (_) => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: StateMessageCard(
                icon: Icons.history_toggle_off_rounded,
                titleKey: 'subscriptionHistoryErrorTitle',
                descriptionKey: 'subscriptionHistoryErrorDescription',
                actionLabelKey: 'commonRetry',
                onPressed: () => controller.loadHistory(),
              ),
            ),
          ),
    );

    if (embedded) {
      return body;
    }

    return SubscriptionPageScaffold(
      titleKey: 'subscriptionHistoryTitle',
      body: body,
    );
  }
}

class _HistoryContent extends StatelessWidget {
  const _HistoryContent({required this.history});

  final PurchaseHistorySnapshot history;

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
              child: Column(
                children: [
                  _HistoryHero(
                    activeCount: history.activePackages.length,
                    expiredCount: history.expiredPackages.length,
                  ),
                  const SizedBox(height: 18),
                  wide
                      ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _HistorySection(
                              titleKey: 'subscriptionActivePlans',
                              emptyTitleKey: 'subscriptionNoActivePlan',
                              items: history.activePackages,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: _HistorySection(
                              titleKey: 'subscriptionExpiredPackages',
                              emptyTitleKey: 'subscriptionNoExpiredPlan',
                              items: history.expiredPackages,
                            ),
                          ),
                        ],
                      )
                      : Column(
                        children: [
                          _HistorySection(
                            titleKey: 'subscriptionActivePlans',
                            emptyTitleKey: 'subscriptionNoActivePlan',
                            items: history.activePackages,
                          ),
                          const SizedBox(height: 18),
                          _HistorySection(
                            titleKey: 'subscriptionExpiredPackages',
                            emptyTitleKey: 'subscriptionNoExpiredPlan',
                            items: history.expiredPackages,
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HistoryHero extends StatelessWidget {
  const _HistoryHero({required this.activeCount, required this.expiredCount});

  final int activeCount;
  final int expiredCount;

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
              'subscriptionHistoryHeadline'.tr,
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'subscriptionHistorySubtitle'.tr,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                _MetricCard(
                  label: 'subscriptionActivePlans'.tr,
                  value: '$activeCount',
                ),
                _MetricCard(
                  label: 'subscriptionExpiredPackages'.tr,
                  value: '$expiredCount',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

class _HistorySection extends StatelessWidget {
  const _HistorySection({
    required this.titleKey,
    required this.emptyTitleKey,
    required this.items,
  });

  final String titleKey;
  final String emptyTitleKey;
  final List<PurchaseHistoryItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(titleKey.tr, style: theme.textTheme.titleLarge),
        ),
        const SizedBox(height: 12),
        if (items.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(emptyTitleKey.tr, style: theme.textTheme.bodyLarge),
            ),
          )
        else
          Column(
            children: [
              for (final item in items) ...[
                HistoryRecordCard(item: item),
                const SizedBox(height: 16),
              ],
            ],
          ),
      ],
    );
  }
}
