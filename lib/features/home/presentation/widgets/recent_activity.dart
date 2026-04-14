import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/home/models/activity_group.dart';
import 'package:smart_carbon_tracking/features/home/models/activity_item.dart';
import 'package:smart_carbon_tracking/features/home/presentation/widgets/activity_tile.dart';

class RecentActivity extends StatelessWidget {
  final List<ActivityItem>? activities;
  final List<ActivityGroup>? groups;
  final bool isGrouped;

  const RecentActivity({
    super.key,
    this.activities,
    this.groups,
    this.isGrouped = false,
  });

  @override
  Widget build(BuildContext context) {
    if (groups != null) {
      return _buildTimeline(context);
    }

    return _buildBody(context);
  }

  Widget _buildTimeline(BuildContext context) {
    if (groups == null || groups!.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groups!.asMap().entries.map((entry) {
        final int groupIndex = entry.key;
        final ActivityGroup group = entry.value;
        final bool isLastGroup = groupIndex == groups!.length - 1;

        return _buildGroupSection(context, group, isLastGroup);
      }).toList(),
    );
  }

  Widget _buildGroupSection(
    BuildContext context,
    ActivityGroup group,
    bool isLastGroup,
  ) {
    final bool isToday = group.label.startsWith('Today');
    final bool isYesterday = group.label.startsWith('Yesterday');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGroupHeader(context, group.label),
        ...group.items.asMap().entries.map((entry) {
          final int index = entry.key;
          final ActivityItem item = entry.value;
          final bool isLastInGroup = index == group.items.length - 1;

          return _buildTimelineItem(
            item: item,
            isLastInGroup: isLastInGroup,
            isToday: isToday,
            isYesterday: isYesterday,
          );
        }),
        if (!isLastGroup) AppSpacing.vGap24,
      ],
    );
  }

  Widget _buildGroupHeader(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        label,
        style: context.text.titleSmall?.copyWith(color: context.colors.outline),
      ),
    );
  }

  Widget _buildTimelineItem({
    required ActivityItem item,
    required bool isLastInGroup,
    required bool isToday,
    required bool isYesterday,
  }) {
    return Column(
      children: [
        AppTimeline(
          isLast: isLastInGroup,
          style: isToday ? TimelineStyle.solid : TimelineStyle.dashed,
          showGlow: isToday,
          dotColor: _getDotColor(isToday, isYesterday),
          lineColor: isToday ? Colors.green.withValues(alpha: 0.3) : null,
          child: ActivityTile(data: item),
        ),
        if (!isLastInGroup) AppSpacing.vGap8,
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    if (activities == null || activities!.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < activities!.length; i++) ...[
          ActivityTile(
            data: activities![i],
            borderRadius: isGrouped
                ? _getGroupedRadius(i, activities!.length)
                : null,
            showBorder: !isGrouped,
          ),
          if (i != activities!.length - 1)
            isGrouped ? const SizedBox(height: 4) : AppSpacing.vGap12,
        ],
      ],
    );
  }

  BorderRadius _getGroupedRadius(int index, int total) {
    const double outerRadius = 22;
    const double innerRadius = 12;

    if (total == 1) return BorderRadius.circular(outerRadius);

    if (index == 0) {
      return const BorderRadius.vertical(
        top: Radius.circular(outerRadius),
        bottom: Radius.circular(innerRadius),
      );
    }

    if (index == total - 1) {
      return const BorderRadius.vertical(
        top: Radius.circular(innerRadius),
        bottom: Radius.circular(outerRadius),
      );
    }

    return BorderRadius.circular(innerRadius);
  }

  Color _getDotColor(bool isToday, bool isYesterday) {
    if (isToday) return Colors.green;
    if (isYesterday) return Colors.blue;
    return Colors.grey[400]!;
  }

  Widget _buildEmptyState() {
    return const AppEmptyState(
      title: 'No activity found',
      subtitle: 'Start tracking your carbon footprint today',
    );
  }
}
