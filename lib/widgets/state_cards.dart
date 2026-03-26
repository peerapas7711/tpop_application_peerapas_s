import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/utils/constants/app_colors.dart';

class StateMessageCard extends StatelessWidget {
  const StateMessageCard({
    super.key,
    required this.icon,
    required this.titleKey,
    required this.descriptionKey,
    required this.actionLabelKey,
    required this.onPressed,
  });

  final IconData icon;
  final String titleKey;
  final String descriptionKey;
  final String actionLabelKey;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: AppColors.roseTint,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primaryRoseDark, size: 34),
            ),
            const SizedBox(height: 18),
            Text(
              titleKey.tr,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              descriptionKey.tr,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: onPressed, child: Text(actionLabelKey.tr)),
          ],
        ),
      ),
    );
  }
}
