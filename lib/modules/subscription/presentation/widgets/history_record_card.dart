import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/utils/constants/app_colors.dart';
import '../../domain/entities/purchase_history_item.dart';

class HistoryRecordCard extends StatelessWidget {
  const HistoryRecordCard({super.key, required this.item});

  final PurchaseHistoryItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = MaterialLocalizations.of(context);

    final purchasedDate = localizations.formatMediumDate(item.purchasedAt);
    final purchasedTime = localizations.formatTimeOfDay(
      TimeOfDay.fromDateTime(item.purchasedAt),
    );
    final accessRange =
        '${localizations.formatMediumDate(item.startAt)} - ${localizations.formatMediumDate(item.endAt)}';

    return Opacity(
      opacity: item.isActive ? 1 : 0.88,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.packageTitleKey.tr,
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.packageSubtitleKey.tr,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          item.isActive
                              ? const Color(0xFFE5F7EE)
                              : AppColors.roseTint,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      item.isActive
                          ? 'subscriptionStatusActive'.tr
                          : 'subscriptionStatusExpired'.tr,
                      style: TextStyle(
                        color:
                            item.isActive
                                ? AppColors.success
                                : AppColors.primaryRoseDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                item.priceLabel,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 16),
              _HistoryDetailRow(
                icon: Icons.schedule_rounded,
                label: 'subscriptionPurchasedAt'.tr,
                value: '$purchasedDate • $purchasedTime',
              ),
              const SizedBox(height: 12),
              _HistoryDetailRow(
                icon: Icons.calendar_month_rounded,
                label: 'subscriptionAccessPeriod'.tr,
                value: accessRange,
              ),
              const SizedBox(height: 12),
              _HistoryDetailRow(
                icon: _paymentIcon(item.paymentMethodKey),
                label: 'subscriptionPaymentMethod'.tr,
                value: item.paymentMethodKey.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _paymentIcon(String paymentMethodKey) {
    switch (paymentMethodKey) {
      case 'paymentApplePay':
        return Icons.phone_iphone_rounded;
      case 'paymentGooglePlay':
        return Icons.android_rounded;
      case 'paymentCreditCard':
      default:
        return Icons.credit_card_rounded;
    }
  }
}

class _HistoryDetailRow extends StatelessWidget {
  const _HistoryDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            color: AppColors.roseTint,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primaryRoseDark, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
