import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/features/home/models/activity_item.dart';

enum ActivityVariant { plain, outline }

class ActivityTile extends StatelessWidget {
  final ActivityItem data;
  final ActivityVariant variant;

  const ActivityTile({
    super.key,
    required this.data,
    this.variant = ActivityVariant.outline,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPlain = variant == ActivityVariant.plain;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isPlain
            ? context.colors.surfaceContainerLowest.withValues(alpha: .8)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isPlain
              ? context.colors.surfaceContainerLowest
              : context.colors.outlineVariant.withValues(alpha: .5),
          width: isPlain ? 1.2 : 1,
        ),
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
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
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              AppSpacing.vGap4,
              Text(
                data.subtitle,
                style: context.text.labelMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Text(
          data.impact,
          style: context.text.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.error,
          ),
        ),
      ],
    );
  }
}
