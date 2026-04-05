import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/scaffold_app.dart';

class PlaceholderNav extends StatelessWidget {
  final String title;
  const PlaceholderNav({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    dynamic getIcon() {
      switch (title.toLowerCase()) {
        case 'scan':
          return HugeIcons.strokeRoundedAiView;
        case 'statistic':
          return HugeIcons.strokeRoundedAnalytics01;
        case 'profile':
          return HugeIcons.strokeRoundedUser;
        default:
          return HugeIcons.strokeRoundedAiView;
      }
    }

    return ScaffoldApp(
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.primary.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.secondary.withValues(alpha: 0.05),
              ),
            ),
          ),
          
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: context.colors.primary.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: HugeIcon(
                      icon: getIcon(),
                      color: context.colors.primary,
                      size: 64,
                    ),
                  ),
                  AppSpacing.vGap32,

                  Text(
                    title,
                    style: context.text.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: context.colors.onSurface,
                    ),
                  ),
                  AppSpacing.vGap12,
                  Text(
                    'Kami sedang menyiapkan fitur ini untuk membantu Anda melacak emisi karbon dengan lebih baik. Tunggu kehadirannya segera!',
                    textAlign: TextAlign.center,
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant.withValues(alpha: 0.7),
                      height: 1.5,
                    ),
                  ),
                  AppSpacing.vGap32,
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: context.colors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: context.colors.outline.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        AppSpacing.hGap8,
                        Text(
                          'Dalam Pengembangan',
                          style: context.text.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.colors.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
