import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

class SummaryBar extends StatelessWidget {
  final double totalKg;
  final int activityCount;
  final String? tag;
  final String title;

  const SummaryBar({
    super.key,
    required this.totalKg,
    required this.activityCount,
    this.tag,
    this.title = 'Carbon Footprint',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colors.primary,
            context.colors.primary.withValues(alpha: 0.82),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          _buildBackgroundIcon(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 18),
              _buildImpactValue(context),
              const SizedBox(height: 4),
              _buildCount(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundIcon(BuildContext context) {
    return Positioned(
      right: -12,
      bottom: -16,
      child: Opacity(
        opacity: 0.06,
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedLeaf01,
          color: context.colors.onPrimary,
          size: 140,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: context.colors.onPrimary.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedTree01,
            color: context.colors.onPrimary,
            size: 16,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: context.text.labelLarge?.copyWith(
            color: context.colors.onPrimary.withValues(alpha: 0.85),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        const Spacer(),
        if (tag != null) _buildTag(context),
      ],
    );
  }

  Widget _buildTag(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: context.colors.onPrimary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.colors.onPrimary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Text(
        tag!,
        style: context.text.labelSmall?.copyWith(
          color: context.colors.onPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildImpactValue(BuildContext context) {
    return Text(
      '+${totalKg.toStringAsFixed(1)} kg CO₂',
      style: context.text.displaySmall?.copyWith(
        color: context.colors.onPrimary,
        fontWeight: FontWeight.w900,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildCount(BuildContext context) {
    return Text(
      '$activityCount activities detected',
      style: context.text.bodyMedium?.copyWith(
        color: context.colors.onPrimary.withValues(alpha: 0.7),
      ),
    );
  }
}
