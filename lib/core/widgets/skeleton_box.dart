import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    required this.height,
    this.width,
    this.radius = 16,
  });

  final double height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: const LinearGradient(
          colors: [AppColors.roseTint, Color(0xFFFFFBFC), AppColors.roseTint],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
