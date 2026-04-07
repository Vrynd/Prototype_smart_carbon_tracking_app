import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/dashed_divider.dart';

class SettingsAction extends StatelessWidget {
  final String safetyTitle;
  final String safetySubtitle;
  final String buttonLabel;
  final bool isConfirmed;
  final ValueChanged<bool> onConfirmedChanged;
  final VoidCallback? onPressed;

  const SettingsAction({
    super.key,
    required this.safetyTitle,
    required this.safetySubtitle,
    required this.buttonLabel,
    required this.isConfirmed,
    required this.onConfirmedChanged,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // Checklist Konfirmasi menggunakan Switch
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              safetyTitle,
              style: context.text.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              safetySubtitle,
              style: context.text.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            trailing: Switch(
              value: isConfirmed,
              onChanged: onConfirmedChanged,
              activeThumbColor: context.colors.primary,
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: DashedDivider(),
          ),

          AppSpacing.vGap16,

          // Tombol Aksi
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: isConfirmed ? onPressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
                foregroundColor: context.colors.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                disabledBackgroundColor: context.colors.surfaceContainerHighest,
              ),
              child: Text(
                buttonLabel,
                style: context.text.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isConfirmed
                      ? context.colors.onPrimary
                      : context.colors.onSurfaceVariant.withValues(
                          alpha: 0.5,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
