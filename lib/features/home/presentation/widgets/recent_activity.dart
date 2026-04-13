import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/app_container.dart';
import 'package:smart_carbon_tracking/core/widgets/app_empty_state.dart';
import 'package:smart_carbon_tracking/core/widgets/dashed_divider.dart';
import 'package:smart_carbon_tracking/features/home/models/activity_period.dart';
import 'package:smart_carbon_tracking/features/home/models/activity_item.dart';
import 'package:smart_carbon_tracking/features/home/presentation/widgets/activity_tile.dart';

class RecentActivity extends StatelessWidget {
  final List<ActivityItem>? activities;
  final ActivityPeriod? selectedPeriod;
  final ValueChanged<ActivityPeriod>? onPeriodChanged;
  final String? title;
  final VoidCallback? onSeeAllTap;
  final bool useContainer;
  final ActivityVariant variant;

  const RecentActivity({
    super.key,
    this.activities,
    this.selectedPeriod,
    this.onPeriodChanged,
    this.title,
    this.onSeeAllTap,
    this.useContainer = true,
    this.variant = ActivityVariant.outline,
  });

  @override
  Widget build(BuildContext context) {
    if (!useContainer) {
      return _buildBody(context);
    }

    final bool hasHeader = onPeriodChanged != null || title != null;

    return AppContainer.compact(
      padding: EdgeInsets.zero,
      borderRadius: 24,
      spacing: 0,
      children: [
        if (hasHeader) ...[
          if (onPeriodChanged != null && selectedPeriod != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: context.colors.surfaceContainerHighest.withValues(
                    alpha: 0.4,
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Row(
                  children: ActivityPeriod.values.map((period) {
                    final isSelected = selectedPeriod == period;
                    return Expanded(
                      child: InkWell(
                        onTap: () => onPeriodChanged!(period),
                        borderRadius: BorderRadius.circular(28),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.green.withValues(alpha: 0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.green.withValues(alpha: 0.6)
                                  : Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            period.label,
                            style: context.text.labelLarge?.copyWith(
                              color: isSelected
                                  ? Colors.green
                                  : context.colors.onSurfaceVariant,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          else if (title != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title!,
                    style: context.text.titleMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (onSeeAllTap != null)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onSeeAllTap,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: context.colors.primary.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: context.colors.primary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          const DashedDivider(),
        ],

        Padding(padding: const EdgeInsets.all(16), child: _buildBody(context)),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    if (activities != null && activities!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < activities!.length; i++) ...[
            ActivityTile(data: activities![i], variant: variant),
            if (i != activities!.length - 1) AppSpacing.vGap12,
          ],
        ],
      );
    }

    return const AppEmptyState(
      title: 'No activity found',
      subtitle: 'Start tracking your carbon footprint today',
    );
  }
}
