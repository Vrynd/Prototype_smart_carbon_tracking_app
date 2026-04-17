import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/history/models/carbon_equivalent.dart';

class CarbonContext extends StatelessWidget {
  final List<CarbonEquivalent> equivalents;

  const CarbonContext({
    super.key,
    required this.equivalents,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      variant: ContainerVariant.basic,
      padding: EdgeInsets.zero,
      backgroundColor: context.colors.surfaceContainerLowest.withValues(alpha: 0.8),
      borderColor: context.colors.surfaceContainerLowest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Environmental Comparison',
              style: context.text.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colors.onSurface,
              ),
            ),
          ),
          const DashedDivider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: equivalents.asMap().entries.map((entry) {
                final int index = entry.key;
                final CarbonEquivalent eq = entry.value;
                return Expanded(
                  child: Row(
                    children: [
                      if (index > 0)
                        Container(
                          width: 1,
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          color: context.colors.outlineVariant.withValues(alpha: 0.4),
                        ),
                      Expanded(
                        child: _EquivalentTile(equivalent: eq),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _EquivalentTile extends StatelessWidget {
  final CarbonEquivalent equivalent;

  const _EquivalentTile({required this.equivalent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: equivalent.color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: HugeIcon(
            icon: equivalent.icon,
            color: equivalent.color,
            size: 22,
          ),
        ),
        AppSpacing.vGap8,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: equivalent.value,
                style: context.text.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: context.colors.onSurface,
                ),
              ),
              TextSpan(
                text: ' ${equivalent.unit}',
                style: context.text.bodySmall?.copyWith(
                  color: context.colors.outline,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.vGap4,
        Text(
          equivalent.label,
          style: context.text.labelSmall?.copyWith(
            color: context.colors.outline,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
