import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/statistic/models/carbon_summary.dart';

class CarbonOverview extends StatelessWidget {
  final CarbonSummary summary;
  final String periodLabel;

  const CarbonOverview({
    super.key,
    required this.summary,
    required this.periodLabel,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Period Emission',
                  style: context.text.bodyMedium?.copyWith(
                    color: context.colors.outline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSpacing.vGap8,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: summary.totalEmission.toStringAsFixed(1),
                        style: context.text.displayMedium?.copyWith(
                          color: context.colors.onSurface,
                        ),
                      ),
                      TextSpan(
                        text: ' kg CO₂e',
                        style: context.text.headlineSmall?.copyWith(
                          color: context.colors.outlineVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          _buildTrendIndicator(context),
        ],
      ),
    );
  }

  Widget _buildTrendIndicator(BuildContext context) {
    final isDown = !summary.isIncreased;
    final color = isDown ? context.colors.primary : context.colors.error;
  
    final double efficiencyRatio = (summary.totalEmission / summary.previousPeriodEmission);
    final int efficiencyScore = (efficiencyRatio * 100).round();
    
    final double progress = efficiencyRatio.clamp(0.0, 1.0);
    return SizedBox(
      width: 55,
      height: 55,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: 5,
            color: context.colors.surfaceContainerHigh,
          ),
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 5,
            strokeCap: StrokeCap.round,
            color: color,
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isDown ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
                  color: color,
                  size: 12,
                ),
                AppSpacing.hGap4,
                Text(
                  '$efficiencyScore%',
                  style: context.text.labelLarge?.copyWith(
                    color: context.colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
