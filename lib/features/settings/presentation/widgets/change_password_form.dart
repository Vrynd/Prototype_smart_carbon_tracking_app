import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/widgets/password_strength_indicator.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/widgets/settings_form.dart';

class ChangePasswordForm extends StatefulWidget {
  final ValueChanged<String>? onNewPasswordChanged;

  const ChangePasswordForm({
    super.key,
    this.onNewPasswordChanged,
  });

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  String _newPassword = '';

  @override
  Widget build(BuildContext context) {
    return SettingsForm(
      children: [
        Text(
          'Current Password',
          style: context.text.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
        ),
        AppSpacing.vGap16,
        TextField(
          obscureText: _obscureCurrent,
          decoration: InputDecoration(
            hintText: 'Enter current password',
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureCurrent ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20,
              ),
              onPressed: () => setState(() => _obscureCurrent = !_obscureCurrent),
            ),
            filled: true,
            fillColor: context.colors.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        AppSpacing.vGap24,

        Text(
          'New Password',
          style: context.text.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
        ),
        AppSpacing.vGap16,
        TextField(
          obscureText: _obscureNew,
          onChanged: (value) {
            setState(() => _newPassword = value);
            widget.onNewPasswordChanged?.call(value);
          },
          decoration: InputDecoration(
            hintText: 'Enter new password',
            prefixIcon: const Icon(Icons.vpn_key_outlined, size: 20),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureNew ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20,
              ),
              onPressed: () => setState(() => _obscureNew = !_obscureNew),
            ),
            filled: true,
            fillColor: context.colors.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        AppSpacing.vGap16,

        PasswordStrengthIndicator(password: _newPassword),
        AppSpacing.vGap24,

        Text(
          'Confirm New Password',
          style: context.text.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
        ),
        AppSpacing.vGap16,
        TextField(
          obscureText: _obscureConfirm,
          decoration: InputDecoration(
            hintText: 'Retype new password',
            prefixIcon: const Icon(Icons.shield_outlined, size: 20),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20,
              ),
              onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
            ),
            filled: true,
            fillColor: context.colors.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
