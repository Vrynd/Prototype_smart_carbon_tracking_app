import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/features/scan/controllers/scan_controller.dart';

class ActionDock extends StatelessWidget {
  const ActionDock({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.colors;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 50),
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: context.colors.onSurface.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIndicator(context),
          AppSpacing.vGap24,
          Consumer<ScanController>(
            builder: (context, controller, child) {
              return Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      context,
                      icon: HugeIcons.strokeRoundedImageAdd01,
                      title: 'Receipt Gallery',
                      subtitle: controller.isPicking
                          ? 'Opening...'
                          : 'Choose from photos',
                      isPrimary: false,
                      onTap: () => controller.pickImageFromGallery(context),
                      isLoading: controller.isPicking,
                    ),
                  ),
                  AppSpacing.hGap16,
                  Expanded(
                    child: _buildActionCard(
                      context,
                      icon: HugeIcons.strokeRoundedNote01,
                      title: 'Type Manually',
                      subtitle: 'Input emission details',
                      isPrimary: true,
                      onTap: () {},
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: context.colors.outline,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required dynamic icon,
    required String title,
    required String subtitle,
    required bool isPrimary,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    final theme = context.colors;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isLoading ? 0.6 : 1.0,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isPrimary ? theme.primary : theme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(24),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: theme.primary.withValues(alpha: 0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isPrimary
                      ? context.colors.surface.withValues(alpha: 0.2)
                      : theme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: isPrimary
                              ? context.colors.surface
                              : theme.primary,
                        ),
                      )
                    : HugeIcon(
                        icon: icon,
                        color: isPrimary
                            ? context.colors.surface
                            : theme.primary,
                        size: 24,
                      ),
              ),
              AppSpacing.vGap16,
              Text(
                title,
                style: context.text.labelLarge?.copyWith(
                  color: isPrimary ? context.colors.surface : theme.onSurface,
                ),
              ),
              AppSpacing.vGap4,
              Text(
                subtitle,
                style: context.text.labelMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isPrimary
                      ? context.colors.surface.withValues(alpha: 0.7)
                      : theme.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
