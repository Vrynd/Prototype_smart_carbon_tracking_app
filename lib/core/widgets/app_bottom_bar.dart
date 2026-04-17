import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/dashed_divider.dart';

class AppBottomBar extends StatelessWidget {
  final Widget? child;
  final String? safetyTitle;
  final String? safetySubtitle;
  final String? buttonLabel;
  final bool isConfirmed;
  final ValueChanged<bool>? onConfirmedChanged;
  final VoidCallback? onActionPressed;
  final bool showDecoration;
  final Color? bgColor;
  final Color? fgColor;

  const AppBottomBar({
    super.key,
    this.child,
    this.safetyTitle,
    this.safetySubtitle,
    this.buttonLabel,
    this.isConfirmed = false,
    this.onConfirmedChanged,
    this.onActionPressed,
    this.showDecoration = true,
    this.bgColor,
    this.fgColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasSwitchSection = onConfirmedChanged != null;

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: showDecoration
            ? const BorderRadius.vertical(top: Radius.circular(28))
            : null,
        boxShadow: showDecoration
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasSwitchSection) ...[
                _buildSafetySection(context),
                if (child != null || buttonLabel != null) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: DashedDivider(),
                  ),
                  AppSpacing.vGap16,
                ],
              ],
              if (child != null) ...[
                child!,
              ],
              if (buttonLabel != null) ...[
                if (child != null) AppSpacing.vGap16,
                _buildActionButton(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSafetySection(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        safetyTitle ?? '',
        style: context.text.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        safetySubtitle ?? '',
        style: context.text.bodySmall?.copyWith(
          color: context.colors.onSurfaceVariant,
        ),
      ),
      trailing: Switch(
        value: isConfirmed,
        onChanged: onConfirmedChanged,
        activeThumbColor: context.colors.primary,
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isConfirmed ? onActionPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? context.colors.primary,
          foregroundColor: fgColor ?? context.colors.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBackgroundColor: context.colors.surfaceContainerHighest,
        ),
        child: Text(
          buttonLabel ?? '',
          style: context.text.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: (isConfirmed && onActionPressed != null)
                ? (fgColor ?? context.colors.onPrimary)
                : context.colors.onSurfaceVariant.withValues(
                    alpha: 0.5,
                  ),
          ),
        ),
      ),
    );
  }
}
