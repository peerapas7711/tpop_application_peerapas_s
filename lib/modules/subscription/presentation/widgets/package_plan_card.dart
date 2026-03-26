import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/utils/constants/app_colors.dart';
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
    final canSelect = !selected;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFFFF2F7) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: selected ? AppColors.primaryRose : AppColors.border,
          width: selected ? 2.4 : 1,
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
        onTap: canSelect ? onSelect : null,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(package.titleKey.tr, style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (selected)
                    const _PlanBadge(
                      icon: Icons.check_circle_rounded,
                      labelKey: 'subscriptionSelected',
                      backgroundColor: Color(0x1FE85D8E),
                      foregroundColor: AppColors.primaryRoseDark,
                      borderColor: Color(0x55E85D8E),
                    ),
                  if (package.isPopular)
                    const _PlanBadge(
                      labelKey: 'subscriptionMostPopular',
                      backgroundColor: AppColors.primaryRose,
                      foregroundColor: Colors.white,
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                package.subtitleKey.tr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 18),
              RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: package.priceLabel,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 28,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextSpan(
                      text: ' / ${package.billingCycleKey.tr}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
              SizedBox(
                width: double.infinity,
                child:
                    selected
                        ? FilledButton.icon(
                          onPressed: null,
                          style: FilledButton.styleFrom(
                            disabledBackgroundColor: AppColors.primaryRose,
                            disabledForegroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          icon: const Icon(Icons.check_rounded, size: 18),
                          label: Text('subscriptionSelected'.tr),
                        )
                        : OutlinedButton.icon(
                          onPressed: onSelect,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryRoseDark,
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: AppColors.primaryRose,
                              width: 1.4,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          icon: const Icon(Icons.touch_app_rounded, size: 18),
                          label: Text('subscriptionSelectPlan'.tr),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlanBadge extends StatelessWidget {
  const _PlanBadge({
    required this.labelKey,
    required this.backgroundColor,
    required this.foregroundColor,
    this.icon,
    this.borderColor,
  });

  final String labelKey;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData? icon;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
        border:
            borderColor == null
                ? null
                : Border.all(color: borderColor!, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: foregroundColor),
            const SizedBox(width: 6),
          ],
          Text(
            labelKey.tr,
            style: TextStyle(
              color: foregroundColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
