import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

enum HeaderStyle { defaultStyle, centered, bold, modern }

class HeaderInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final HeaderStyle variant;
  final Color? iconColor;
  final Color? iconBgColor;
  final Color? backgroundColor;

  const HeaderInfo({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.variant = HeaderStyle.centered,
    this.iconColor,
    this.iconBgColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case HeaderStyle.defaultStyle:
        return _buildDefault(context);
      case HeaderStyle.centered:
        return _buildCentered(context);
      case HeaderStyle.bold:
        return _buildBold(context);
      case HeaderStyle.modern:
        return _buildModern(context);
    }
  }

  Widget _buildDefault(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: iconBgColor ??
                  context.colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 40,
              color: iconColor ?? context.colors.primary,
            ),
          ),
        ),
        AppSpacing.vGap24,
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: context.text.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onSurface,
            ),
          ),
        ),
        AppSpacing.vGap8,
        Center(
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: context.text.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCentered(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ??
            context.colors.surfaceContainerLowest.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.colors.surfaceContainerLowest,
          width: 1.2,
        ),
      ),
      child: _buildDefault(context),
    );
  }

  Widget _buildBold(BuildContext context) {
    final bgColor = backgroundColor ?? context.colors.primary;
    final onBgColor = context.colors.onPrimary;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bgColor, bgColor.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: bgColor.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: iconBgColor ?? onBgColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: iconColor ?? onBgColor),
            ),
          ),
          AppSpacing.vGap20,
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: context.text.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: onBgColor,
              ),
            ),
          ),
          AppSpacing.vGap8,
          Center(
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: context.text.bodyMedium?.copyWith(
                color: onBgColor.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModern(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor ??
            context.colors.surfaceContainerLowest.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.colors.surfaceContainerLowest,
          width: 1.2,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -15,
            top: -15,
            child: Opacity(
              opacity: 0.07,
              child: Icon(
                icon,
                size: 150,
                color: iconColor ?? context.colors.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSurface,
                  ),
                ),
                AppSpacing.vGap8,
                Text(
                  subtitle,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
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
