import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/utils/constants/app_colors.dart';

class SubscriptionPageScaffold extends StatelessWidget {
  const SubscriptionPageScaffold({
    super.key,
    required this.titleKey,
    required this.body,
    this.bottomNavigationBar,
  });

  final String titleKey;
  final Widget body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titleKey.tr)),
      body: DecoratedBox(
        decoration: const BoxDecoration(color: AppColors.canvas),
        child: SafeArea(child: body),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
