import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

class Toolbar extends StatelessWidget {
  final VoidCallback onBackTap;
  final VoidCallback onFlashTap;
  final String bannerTitle;

  const Toolbar({
    super.key,
    required this.onBackTap,
    required this.onFlashTap,
    this.bannerTitle = 'Scan receipt to get points',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ToolButton(
              icon: HugeIcons.strokeRoundedArrowLeft01,
              onTap: onBackTap,
            ),
            _TopBanner(title: bannerTitle),
            _ToolButton(
              icon: HugeIcons.strokeRoundedFlashlight,
              onTap: onFlashTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBanner extends StatelessWidget {
  final String title;

  const _TopBanner({required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: context.colors.surface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: context.colors.surface.withValues(alpha: 0.1),
              width: 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: context.colors.surface,
                size: 14,
              ),
              AppSpacing.hGap12,
              Text(
                title,
                style: context.text.labelMedium?.copyWith(
                  color: context.colors.surface,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToolButton extends StatelessWidget {
  final dynamic icon;
  final VoidCallback onTap;

  const _ToolButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.colors.onSurface.withValues(alpha: 0.4),
              shape: BoxShape.circle,
              border: Border.all(color: context.colors.surface.withValues(alpha: 0.1)),
            ),
            child: HugeIcon(
              icon: icon,
              color: context.colors.surface,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
