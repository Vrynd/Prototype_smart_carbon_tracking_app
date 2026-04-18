import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/statistic/models/impact_summary.dart';

class SustainabilityImpact extends StatelessWidget {
  final List<ImpactSummary> impacts;

  const SustainabilityImpact({
    super.key,
    required this.impacts,
  });

  @override
  Widget build(BuildContext context) {
    if (impacts.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.45,
      ),
      itemCount: impacts.length,
      itemBuilder: (context, index) {
        return _ImpactCard(impact: impacts[index]);
      },
    );
  }
}

class _ImpactCard extends StatelessWidget {
  final ImpactSummary impact;

  const _ImpactCard({required this.impact});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: impact.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: HugeIcon(
                  icon: impact.icon,
                  color: impact.color,
                  size: 16,
                ),
              ),
              AppSpacing.hGap8,
              Expanded(
                child: Text(
                  impact.label,
                  style: context.text.labelMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                impact.value,
                style: context.text.titleLarge?.copyWith(
                  color: context.colors.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              AppSpacing.vGap4,
              Text(
                impact.subtitle,
                style: context.text.labelMedium?.copyWith(
                  color: context.colors.outline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
