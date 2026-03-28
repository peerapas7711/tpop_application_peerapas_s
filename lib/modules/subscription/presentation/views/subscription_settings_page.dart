import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/utils/constants/app_colors.dart';

import '../controllers/subscription_settings_controller.dart';
import '../widgets/subscription_page_scaffold.dart';

class SubscriptionSettingsPage extends GetView<SubscriptionSettingsController> {
  const SubscriptionSettingsPage({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final body = SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _LanguageSettingsCard(),
              SizedBox(height: 18),
              _ClearHistoryCard(),
              SizedBox(height: 18),
              _AppVersionCard(),
            ],
          ),
        ),
      ),
    );

    if (embedded) {
      return body;
    }

    return SubscriptionPageScaffold(
      titleKey: 'subscriptionSettingsTitle',
      body: body,
    );
  }
}

class _LanguageSettingsCard extends GetView<SubscriptionSettingsController> {
  const _LanguageSettingsCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _SettingsIcon(icon: Icons.language_rounded),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'commonLanguage'.tr,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'subscriptionSettingsLanguageDescription'.tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() {
              final selectedLanguageCode =
                  controller.selectedLanguageCode.value;
              final changingLanguageCode =
                  controller.changingLanguageCode.value;
              final isUpdatingLanguage = controller.isUpdatingLanguage.value;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _LanguageChip(
                    label: 'subscriptionSettingsEnglish'.tr,
                    selected:
                        selectedLanguageCode == 'en' &&
                        changingLanguageCode.isEmpty,
                    loading: changingLanguageCode == 'en',
                    enabled:
                        !isUpdatingLanguage && selectedLanguageCode != 'en',
                    onTap:
                        () =>
                            controller.updateLanguage(const Locale('en', 'US')),
                  ),
                  _LanguageChip(
                    label: 'subscriptionSettingsThai'.tr,
                    selected:
                        selectedLanguageCode == 'th' &&
                        changingLanguageCode.isEmpty,
                    loading: changingLanguageCode == 'th',
                    enabled:
                        !isUpdatingLanguage && selectedLanguageCode != 'th',
                    onTap:
                        () =>
                            controller.updateLanguage(const Locale('th', 'TH')),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _AppVersionCard extends GetView<SubscriptionSettingsController> {
  const _AppVersionCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SettingsIcon(icon: Icons.info_outline_rounded),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'subscriptionSettingsAppVersion'.tr,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'subscriptionSettingsAppVersionDescription'.tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    if (controller.isLoadingVersion.value) {
                      return const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: AppColors.primaryRose,
                        ),
                      );
                    }

                    final versionLabel = controller.appVersion.value;
                    return Text(
                      versionLabel.isEmpty
                          ? 'subscriptionSettingsVersionUnavailable'.tr
                          : versionLabel,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClearHistoryCard extends GetView<SubscriptionSettingsController> {
  const _ClearHistoryCard();

  Future<void> _confirmClearHistory(BuildContext context) async {
    final shouldClear = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text('subscriptionSettingsClearHistoryConfirmTitle'.tr),
            content: Text(
              'subscriptionSettingsClearHistoryConfirmDescription'.tr,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text('commonCancel'.tr),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.danger,
                  foregroundColor: Colors.white,
                ),
                child: Text('subscriptionSettingsClearHistoryConfirmAction'.tr),
              ),
            ],
          ),
    );

    if (shouldClear == true) {
      await controller.clearPurchaseHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SettingsIcon(
                  icon: Icons.delete_sweep_rounded,
                  backgroundColor: Color(0xFFFFE5EA),
                  iconColor: AppColors.danger,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'subscriptionSettingsClearHistoryTitle'.tr,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'subscriptionSettingsClearHistoryDescription'.tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() {
              final isClearing = controller.isClearingHistory.value;

              return FilledButton.icon(
                onPressed:
                    isClearing ? null : () => _confirmClearHistory(context),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.danger,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                ),
                icon:
                    isClearing
                        ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                        : const Icon(Icons.delete_forever_rounded, size: 20),
                label: Text(
                  isClearing
                      ? 'subscriptionSettingsClearHistoryProcessing'.tr
                      : 'subscriptionSettingsClearHistoryButton'.tr,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({
    required this.label,
    required this.selected,
    required this.loading,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool loading;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isActive = selected || loading;
    final textColor = isActive ? Colors.white : AppColors.primaryRoseDark;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 180),
      opacity: enabled || isActive ? 1 : 0.55,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: enabled ? onTap : null,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryRose : AppColors.roseTint,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
              ),
              if (loading) ...[
                const SizedBox(width: 10),
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsIcon extends StatelessWidget {
  const _SettingsIcon({
    required this.icon,
    this.backgroundColor = AppColors.roseTint,
    this.iconColor = AppColors.primaryRoseDark,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: 22),
    );
  }
}
