import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/dashed_divider.dart';
import 'package:smart_carbon_tracking/core/widgets/app_container.dart';
import 'package:smart_carbon_tracking/features/home/models/activity_category.dart';

class FilterCategory extends StatelessWidget {
  final ActivityCategory selectedCategory;
  final ValueChanged<ActivityCategory> onCategoryChanged;

  const FilterCategory({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer.compact(
      padding: EdgeInsets.zero,
      borderRadius: 24,
      spacing: 0,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Text(
            'Activity Categories',
            style: context.text.titleMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const DashedDivider(),

        Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: ActivityCategory.values.length,
            itemBuilder: (context, index) {
              final category = ActivityCategory.values[index];
              final isSelected = selectedCategory == category;

              return _CategoryItem(
                icon: category.icon,
                label: category.label,
                isSelected: isSelected,
                activeColor: category.color,
                onTap: () => onCategoryChanged(category),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final dynamic icon;
  final String label;
  final bool isSelected;
  final Color activeColor;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color displayColor = isSelected
        ? activeColor
        : context.colors.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? activeColor.withValues(alpha: 0.1)
                      : context.colors.surfaceContainerLowest.withValues(
                          alpha: 0.6,
                        ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? activeColor.withValues(alpha: 0.4)
                        : context.colors.outlineVariant.withValues(alpha: 0.6),
                    width: isSelected ? 1.5 : 1.1,
                  ),
                ),
                child: HugeIcon(
                  icon: icon,
                  color: isSelected
                      ? activeColor
                      : context.colors.onSurfaceVariant,
                  size: 24,
                ),
              ),

              if (isSelected)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: activeColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.colors.surfaceContainerHigh,
                        width: 1.5,
                      ),
                    ),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedCheckmarkBadge01,
                      color: context.colors.surface,
                      size: 12,
                    ),
                  ),
                ),
            ],
          ),
          AppSpacing.vGap8,
          Text(
            label,
            style: context.text.labelMedium?.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: displayColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
