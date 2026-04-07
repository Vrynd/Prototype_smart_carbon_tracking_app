import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    // Kriteria Validasi
    final bool hasMinLength = password.length >= 8;
    final bool hasUpperLower =
        password.contains(RegExp(r'[a-z]')) && password.contains(RegExp(r'[A-Z]'));
    final bool hasDigit = password.contains(RegExp(r'[0-9]'));
    final bool hasSpecialChar =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Hitung Skor (0 - 4)
    int score = 0;
    if (hasMinLength) score++;
    if (hasUpperLower) score++;
    if (hasDigit) score++;
    if (hasSpecialChar) score++;

    // Tentukan Label dan Warna menggunakan standar Colors
    String label = 'Empty';
    Color color = context.colors.surfaceContainerHighest;
    
    if (password.isNotEmpty) {
      if (score <= 1) {
        label = 'Weak';
        color = Colors.red;
      } else if (score <= 2) {
        label = 'Fair';
        color = Colors.orange;
      } else if (score <= 3) {
        label = 'Good';
        color = Colors.amber;
      } else {
        label = 'Strong';
        color = Colors.green;
      }
    }

    const duration = Duration(milliseconds: 150);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (index) {
            bool isActive = index < score && password.isNotEmpty;
            return Expanded(
              child: AnimatedContainer(
                duration: duration,
                margin: EdgeInsets.only(right: index == 3 ? 0 : 6),
                height: 5,
                decoration: BoxDecoration(
                  color: isActive ? color : context.colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),
        AppSpacing.vGap12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Security Level',
              style: context.text.labelSmall?.copyWith(
                color: context.colors.onSurfaceVariant.withValues(alpha: 0.7),
                letterSpacing: 0.5,
              ),
            ),
            AnimatedDefaultTextStyle(
              duration: duration,
              style: context.text.labelSmall!.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: color == context.colors.surfaceContainerHighest 
                    ? context.colors.onSurfaceVariant.withValues(alpha: 0.5)
                    : color,
              ),
              child: Text(label.toUpperCase()),
            ),
          ],
        ),
        AppSpacing.vGap20,
        _RequirementItem(
          label: 'At least 8 characters',
          isMet: hasMinLength,
        ),
        AppSpacing.vGap4,
        _RequirementItem(
          label: 'Uppercase & Lowercase letters',
          isMet: hasUpperLower,
        ),
        AppSpacing.vGap4,
        _RequirementItem(
          label: 'Contains numbers (0-9)',
          isMet: hasDigit,
        ),
        AppSpacing.vGap4,
        _RequirementItem(
          label: 'Contains special characters (!@#\$)',
          isMet: hasSpecialChar,
        ),
      ],
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String label;
  final bool isMet;

  const _RequirementItem({
    required this.label,
    required this.isMet,
  });

  @override
  Widget build(BuildContext context) {
    final color = isMet ? Colors.green : context.colors.onSurfaceVariant.withValues(alpha: 0.3);
    
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            isMet ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
            size: 16,
            color: color,
          ),
        ),
        AppSpacing.hGap12,
        Expanded(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: context.text.bodySmall!.copyWith(
              color: isMet ? context.colors.onSurface : context.colors.onSurfaceVariant.withValues(alpha: 0.5),
              fontSize: 12,
              fontWeight: isMet ? FontWeight.w500 : FontWeight.normal,
            ),
            child: Text(label),
          ),
        ),
      ],
    );
  }
}
