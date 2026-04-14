import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/features/home/models/activity_item.dart';

class ActivityTile extends StatelessWidget {
  final ActivityItem data;
  final BorderRadius? borderRadius;
  final bool showBorder;

  const ActivityTile({
    super.key,
    required this.data,
    this.borderRadius,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest.withValues(alpha: .8),
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        border: showBorder
            ? Border.all(
                color: context.colors.surfaceContainerLowest,
                width: 1.2,
              )
            : null,
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: data.iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: HugeIcon(icon: data.icon, color: data.iconColor, size: 22),
        ),
        AppSpacing.hGap16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: context.text.titleMedium?.copyWith(
                  color: context.colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppSpacing.vGap4,
              Text(
                data.subtitle,
                style: context.text.labelMedium?.copyWith(
                  color: context.colors.outline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Text(
          data.impact,
          style: context.text.labelLarge?.copyWith(color: context.colors.error),
        ),
      ],
    );
  }
}
