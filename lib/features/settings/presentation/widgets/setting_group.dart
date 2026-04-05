import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/dashed_divider.dart';

class SettingGroup extends StatelessWidget {
  final String title;
  final List<Widget> items;
  final Color? backgroundColor;

  const SettingGroup({
    super.key,
    required this.title,
    required this.items,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: context.text.titleMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.colors.surfaceContainerLowest.withValues(
                alpha: .7,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.colors.surfaceContainerLowest,
                width: 1.2,
              ),
            ),
            child: Column(
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  items[i],
                  if (i < items.length - 1) const DashedDivider(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
