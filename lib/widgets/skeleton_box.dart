import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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

  static const _baseColor = Color(0xFFFFE3ED);
  static const _fillColor = Color(0xFFF7AFC8);
  static const _highlightColor = Color(0xFFFFFBFD);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _baseColor,
      highlightColor: _highlightColor,
      period: const Duration(milliseconds: 1050),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: _fillColor,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
