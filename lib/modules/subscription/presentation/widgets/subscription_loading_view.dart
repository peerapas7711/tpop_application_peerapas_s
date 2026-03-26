import 'package:flutter/material.dart';
import 'package:tpop_application_peerapas_s/widgets/skeleton_box.dart';

class SubscriptionLoadingView extends StatelessWidget {
  const SubscriptionLoadingView({
    super.key,
    this.recordCount = 2,
    this.includeSidebar = true,
  });

  final int recordCount;
  final bool includeSidebar;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1120),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SkeletonBox(height: 180, radius: 30),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth >= 900 && includeSidebar;

                  if (!wide) {
                    return Column(
                      children: [
                        for (var i = 0; i < recordCount; i++) ...[
                          const SkeletonBox(height: 320, radius: 28),
                          const SizedBox(height: 18),
                        ],
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 4,
                        child: SkeletonBox(height: 250, radius: 28),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            for (var i = 0; i < recordCount; i++) ...[
                              const SkeletonBox(height: 320, radius: 28),
                              const SizedBox(height: 18),
                            ],
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
