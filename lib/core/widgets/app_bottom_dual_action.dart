import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/core.dart';

class AppBottomDualAction extends StatelessWidget {
  final String safetyTitle;
  final String safetySubtitle;
  final bool isConfirmed;
  final ValueChanged<bool> onConfirmedChanged;

  final String primaryLabel;
  final VoidCallback? onPrimaryPressed;
  final Color? primaryColor;
  final int primaryFlex;

  final String secondaryLabel;
  final VoidCallback? onSecondaryPressed;
  final dynamic secondaryIcon;
  final int secondaryFlex;

  const AppBottomDualAction({
    super.key,
    required this.safetyTitle,
    required this.safetySubtitle,
    required this.isConfirmed,
    required this.onConfirmedChanged,
    required this.primaryLabel,
    this.onPrimaryPressed,
    this.primaryColor,
    this.primaryFlex = 2,
    required this.secondaryLabel,
    this.onSecondaryPressed,
    this.secondaryIcon,
    this.secondaryFlex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return AppBottomBar(
      safetyTitle: safetyTitle,
      safetySubtitle: safetySubtitle,
      isConfirmed: isConfirmed,
      onConfirmedChanged: onConfirmedChanged,
      child: Row(
        spacing: 12,
        children: [
          // ─── Secondary Action (e.g., Share) ───
          if (secondaryFlex > 0)
            Expanded(
              flex: secondaryFlex,
              child: _buildSecondaryButton(context),
            ),

          // ─── Primary Action (e.g., Delete/Save) ───
          Expanded(
            flex: primaryFlex,
            child: _buildPrimaryButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSecondaryPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: context.colors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: context.colors.primary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              if (secondaryIcon != null)
                HugeIcon(
                  icon: secondaryIcon,
                  color: context.colors.primary,
                  size: 20,
                ),
              Text(
                secondaryLabel,
                style: context.text.titleSmall?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    final bool isActive = isConfirmed && onPrimaryPressed != null;

    return SizedBox(
      height: 54,
      child: ElevatedButton(
        onPressed: isActive ? onPrimaryPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor ?? context.colors.primary,
          foregroundColor: context.colors.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBackgroundColor: context.colors.surfaceContainerHighest,
        ),
        child: Text(
          primaryLabel,
          style: context.text.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isActive
                ? context.colors.onPrimary
                : context.colors.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
