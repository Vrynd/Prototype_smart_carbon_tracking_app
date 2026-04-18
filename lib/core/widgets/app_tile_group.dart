import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/dashed_divider.dart';

enum GroupVariant {
  classic,
  modern,
}

class AppTileGroup extends StatelessWidget {
  final List<Widget> children;
  final String? title;
  final GroupVariant variant;
  final Color? backgroundColor;

  const AppTileGroup({
    super.key,
    required this.children,
    this.title,
    this.variant = GroupVariant.modern,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == GroupVariant.classic) {
      return _buildClassic(context);
    }
    return _buildModern(context);
  }

  Widget _buildClassic(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.colors.outlineVariant.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildModern(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title!,
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
                for (var i = 0; i < children.length; i++) ...[
                  children[i],
                  if (i < children.length - 1) const DashedDivider(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
