import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/section_header.dart';

class RecentActivity extends StatelessWidget {
  final List<ActivityItemData> activities;
  final VoidCallback? onSeeAllTap;

  const RecentActivity({
    super.key,
    required this.activities,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Recent Activity',
          onActionTap: onSeeAllTap,
        ),
        ...activities.map((item) => _ActivityTile(data: item)),
      ],
    );
  }
}

class ActivityItemData {
  final String title;
  final String subtitle;
  final String impact;
  final dynamic icon;
  final Color iconColor;

  const ActivityItemData({
    required this.title,
    required this.subtitle,
    required this.impact,
    required this.icon,
    required this.iconColor,
  });
}

class _ActivityTile extends StatelessWidget {
  final ActivityItemData data;

  const _ActivityTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: data.iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: HugeIcon(
              icon: data.icon,
              color: data.iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
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
                const SizedBox(height: 4),
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
      ),
    );
  }
}
