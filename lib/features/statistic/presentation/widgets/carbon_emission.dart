import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/statistic/models/category_breakdown.dart';

class CarbonEmission extends StatelessWidget {
  final List<CategoryBreakdown> breakdowns;

  const CarbonEmission({
    super.key,
    required this.breakdowns,
  });

  @override
  Widget build(BuildContext context) {
    if (breakdowns.isEmpty) return const SizedBox.shrink();

    return AppContainer(
      padding: EdgeInsets.zero,
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < breakdowns.length; i++) ...[
            _CarbonEmissionItem(breakdown: breakdowns[i]),
            if (i < breakdowns.length - 1) 
              const DashedDivider(),
          ],
        ],
      ),
    );
  }
}

class _CarbonEmissionItem extends StatelessWidget {
  final CategoryBreakdown breakdown;

  const _CarbonEmissionItem({
    required this.breakdown,
  });

  @override
  Widget build(BuildContext context) {
    return AppSettingTile(
      variant: TileVariant.classic,
      icon: breakdown.icon,
      iconColor: breakdown.color,
      title: breakdown.name,
      subtitle: '${breakdown.amount.toStringAsFixed(1)} kg CO₂e',
      trailing: _buildCircularProgress(context),
      onTap: () {},
    );
  }

  Widget _buildCircularProgress(BuildContext context) {
    final double progress = (breakdown.percentage / 100).clamp(0.0, 1.0);
    
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: 4,
            color: context.colors.surfaceContainerHigh.withValues(alpha: 0.5),
          ),
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            strokeCap: StrokeCap.round,
            color: breakdown.color,
          ),
          Center(
            child: Text(
              '${breakdown.percentage.round()}%',
              style: context.text.labelSmall?.copyWith(
                color: context.colors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
