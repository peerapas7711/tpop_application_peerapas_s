import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/widgets/locale_toggle_button.dart';
import '../../../../core/theme/app_colors.dart';

class SubscriptionPageScaffold extends StatelessWidget {
  const SubscriptionPageScaffold({
    super.key,
    required this.titleKey,
    required this.body,
    this.showHistoryShortcut = false,
    this.showPlansShortcut = false,
  });

  final String titleKey;
  final Widget body;
  final bool showHistoryShortcut;
  final bool showPlansShortcut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(titleKey.tr),
        actions: [
          if (showPlansShortcut)
            IconButton(
              tooltip: 'commonBrowsePlans'.tr,
              onPressed: () => Get.offNamed(AppRoutes.purchasePackages),
              icon: const Icon(Icons.sell_outlined),
            ),
          if (showHistoryShortcut)
            IconButton(
              tooltip: 'commonViewHistory'.tr,
              onPressed: () => Get.toNamed(AppRoutes.purchaseHistory),
              icon: const Icon(Icons.history_rounded),
            ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(child: LocaleToggleButton()),
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF7FA), Color(0xFFFFECF3), Color(0xFFFFFAFD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -40,
              child: _GlowCircle(
                size: 220,
                color: AppColors.roseTintStrong.withValues(alpha: 0.55),
              ),
            ),
            Positioned(
              top: 180,
              right: -20,
              child: _GlowCircle(
                size: 160,
                color: AppColors.roseTint.withValues(alpha: 0.85),
              ),
            ),
            SafeArea(child: body),
          ],
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
