import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/subscription_package.dart';

class PurchaseSummaryCard extends StatelessWidget {
  const PurchaseSummaryCard({
    super.key,
    required this.package,
    required this.isPurchasing,
    required this.onPressed,
  });

  final SubscriptionPackage package;
  final bool isPurchasing;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'subscriptionSelectedPlan'.tr,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(package.titleKey.tr, style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(package.subtitleKey.tr, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.roseTint,
                borderRadius: BorderRadius.circular(20),
              ),
              child: RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: package.priceLabel,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 26,
                      ),
                    ),
                    TextSpan(text: ' / ${package.billingCycleKey.tr}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'subscriptionPaymentSecure'.tr,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryRoseDark,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: isPurchasing ? null : onPressed,
              child:
                  isPurchasing
                      ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: Colors.white,
                        ),
                      )
                      : Text('subscriptionBuyNow'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
