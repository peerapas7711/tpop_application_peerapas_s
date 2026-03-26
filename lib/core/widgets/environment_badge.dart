import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_environment.dart';
import '../theme/app_colors.dart';

class EnvironmentBadge extends StatelessWidget {
  const EnvironmentBadge({super.key, required this.environment});

  final AppEnvironment environment;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        environment.isProduction ? AppColors.roseTint : const Color(0xFFFFEBD9);
    final foregroundColor =
        environment.isProduction
            ? AppColors.primaryRoseDark
            : const Color(0xFF8A4C06);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '${'commonCurrentEnvironment'.tr}: ${environment.flavorLabelKey.tr}',
        style: TextStyle(
          color: foregroundColor,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
