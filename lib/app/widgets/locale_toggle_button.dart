import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../translations/app_translations.dart';

class LocaleToggleButton extends StatelessWidget {
  const LocaleToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Get.locale ?? AppTranslations.fallbackLocale;
    final isThai = currentLocale.languageCode == 'th';

    return Tooltip(
      message: 'commonLanguage'.tr,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () {
          Get.updateLocale(
            isThai ? const Locale('en', 'US') : const Locale('th', 'TH'),
          );
        },
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.78),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LocaleLabel(label: 'EN', active: !isThai),
              const SizedBox(width: 8),
              Container(width: 1, height: 14, color: AppColors.border),
              const SizedBox(width: 8),
              _LocaleLabel(label: 'TH', active: isThai),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocaleLabel extends StatelessWidget {
  const _LocaleLabel({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: active ? AppColors.primaryRoseDark : AppColors.textSecondary,
        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
      ),
    );
  }
}
