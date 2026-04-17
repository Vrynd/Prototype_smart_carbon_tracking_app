import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/history/models/history_item.dart';

class TotalEmission extends StatelessWidget {
  final HistoryItem item;
  final double averageDailyCarbon;

  const TotalEmission({
    super.key,
    required this.item,
    required this.averageDailyCarbon,
  });

  @override
  Widget build(BuildContext context) {
    // ─── Comparison Logic ───
    final double ratio = averageDailyCarbon > 0
        ? item.totalCarbonKg / averageDailyCarbon
        : 0;
    
    final bool isLower = ratio < 1.0;
    final double diffPercentage = ((1.0 - ratio).abs() * 100);
    
    // Status color based on ratio
    Color statusColor = item.riskLevel.color;
    if (ratio < 0.8) {
      statusColor = Colors.green;
    } else if (ratio < 1.3) {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.red;
    }

    return AppContainer(
      variant: ContainerVariant.basic,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      backgroundColor: context.colors.surfaceContainerLowest.withValues(alpha: 0.8),
      borderColor: context.colors.surfaceContainerLowest,
      child: Column(
        children: [
          // ─── Layered Glow Icon ───
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer Glow
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      statusColor.withValues(alpha: 0.2),
                      statusColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
              // Inner Aura
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.1),
                    width: 2,
                  ),
                ),
                child: HugeIcon(
                  icon: item.categoryIcon ?? HugeIcons.strokeRoundedShoppingBag01,
                  color: statusColor,
                  size: 44,
                ),
              ),
            ],
          ),
          AppSpacing.vGap24,

          // ─── Modern Typography ───
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: item.totalCarbonKg.toStringAsFixed(1),
                  style: context.text.displayMedium?.copyWith(
                    color: context.colors.onSurface,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
                const TextSpan(text: ' '),
                TextSpan(
                  text: 'kg CO2e',
                  style: context.text.titleLarge?.copyWith(
                    color: context.colors.outline.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.vGap4,
          Text(
            'Total Estimated Impact',
            style: context.text.bodyMedium?.copyWith(
              color: context.colors.outline,
              letterSpacing: 0.5,
            ),
          ),
          
          AppSpacing.vGap24,

          // ─── Comparison Capsule ───
          if (averageDailyCarbon > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: statusColor.withValues(alpha: 0.12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isLower ? Icons.trending_down_rounded : Icons.trending_up_rounded,
                    color: statusColor,
                    size: 16,
                  ),
                  AppSpacing.hGap8,
                  Text(
                    '${diffPercentage.toStringAsFixed(0)}% ${isLower ? 'lower' : 'higher'} than daily avg',
                    style: context.text.labelMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
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
