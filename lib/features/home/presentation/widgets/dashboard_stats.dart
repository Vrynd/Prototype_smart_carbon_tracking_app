import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/features/home/models/dashboard_stats_model.dart';

class DashboardStats extends StatelessWidget {
  final DashboardStatsModel stats;

  const DashboardStats({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _StatCard(
                height: 180,
                color: context.colors.primary,
                icon: HugeIcons.strokeRoundedStar,
                label: 'Eco Score',
                value: stats.ecoScore,
              ),
              AppSpacing.vGap16,
              _StatCard(
                height: 140,
                color: context.colors.surfaceContainerHigh,
                icon: HugeIcons.strokeRoundedZap,
                iconAccentColor: Colors.orange.shade600,
                label: 'Scan Streak',
                value: stats.scanStreak,
              ),
            ],
          ),
        ),
        AppSpacing.hGap16,
        Expanded(
          child: Column(
            children: [
              _StatCard(
                height: 140,
                color: context.colors.surfaceContainerHigh,
                icon: HugeIcons.strokeRoundedInvoice,
                iconAccentColor: Colors.blue.shade600,
                label: 'Last Scan',
                value: stats.lastScan,
              ),
              AppSpacing.vGap16,
              _StatCard(
                height: 180,
                color: context.colors.secondary,
                icon: HugeIcons.strokeRoundedTree01,
                label: 'Planet Impact',
                value: stats.planetImpact,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final double height;
  final Color color;
  final dynamic icon;
  final Color? iconAccentColor;
  final String label;
  final String value;

  const _StatCard({
    required this.height,
    required this.color,
    required this.icon,
    required this.label,
    required this.value,
    this.iconAccentColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color contentColor = color == context.colors.primary
        ? context.colors.onPrimary
        : (color == context.colors.secondary
              ? context.colors.onSecondary
              : context.colors.onSurface);

    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: contentColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: HugeIcon(
              icon: icon,
              color: iconAccentColor ?? contentColor,
              size: 20,
            ),
          ),
          AppSpacing.vGap12,
          Text(
            label,
            style: context.text.labelLarge?.copyWith(
              color: contentColor.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style:
                (height > 150
                        ? context.text.displaySmall
                        : context.text.headlineMedium)
                    ?.copyWith(
                      color: contentColor,
                      fontWeight: FontWeight.bold,
                    ),
          ),
        ],
      ),
    );
  }
}
