import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/subscription_package.dart';

class PackagePlanCard extends StatelessWidget {
  const PackagePlanCard({
    super.key,
    required this.package,
    required this.selected,
    required this.onSelect,
  });

  final SubscriptionPackage package;
  final bool selected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: selected ? AppColors.primaryRose : AppColors.border,
          width: selected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryRose.withValues(
              alpha: selected ? 0.18 : 0.08,
            ),
            blurRadius: selected ? 24 : 12,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onSelect,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      package.titleKey.tr,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  if (package.isPopular)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryRose,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'subscriptionMostPopular'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(package.subtitleKey.tr, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 18),
              RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: package.priceLabel,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 28,
                      ),
                    ),
                    TextSpan(text: ' / ${package.billingCycleKey.tr}'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                package.descriptionKey.tr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'subscriptionIncludes'.tr,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              ...package.featureKeys.map(
                (featureKey) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 18,
                          color: AppColors.primaryRose,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          featureKey.tr,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton.tonal(
                onPressed: onSelect,
                style: FilledButton.styleFrom(
                  backgroundColor:
                      selected ? AppColors.primaryRose : AppColors.roseTint,
                  foregroundColor:
                      selected ? Colors.white : AppColors.primaryRoseDark,
                ),
                child: Text(
                  selected
                      ? 'subscriptionSelected'.tr
                      : 'subscriptionSelectPlan'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
