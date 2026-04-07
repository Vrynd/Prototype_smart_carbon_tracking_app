import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/header_app.dart';
import 'package:smart_carbon_tracking/core/widgets/scaffold_app.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/widgets/settings_action.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/widgets/change_password_form.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/widgets/header_info.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldApp(
      backgroundColor: context.colors.surfaceContainerLow,
      appBar: const HeaderApp(
        title: 'Change Password',
        variant: HeaderVariant.detail,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          const HeaderInfo(
            icon: Icons.lock_reset_rounded,
            title: 'Create Strong Password',
            variant: HeaderStyle.modern,
            subtitle:
                'Your new password must be different\nfrom previous used passwords.',
          ),
          AppSpacing.vGap16,

          ChangePasswordForm(
            children: [
              Text(
                'Current Password',
                style: context.text.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              AppSpacing.vGap8,
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter current password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
                  suffixIcon: const Icon(
                    Icons.visibility_off_outlined,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: context.colors.surfaceContainerLow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              AppSpacing.vGap20,
              Text(
                'New Password',
                style: context.text.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              AppSpacing.vGap8,
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter new password',
                  prefixIcon: const Icon(Icons.vpn_key_outlined, size: 20),
                  suffixIcon: const Icon(
                    Icons.visibility_off_outlined,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: context.colors.surfaceContainerLow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              AppSpacing.vGap20,

              Text(
                'Confirm New Password',
                style: context.text.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              AppSpacing.vGap8,
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Retype new password',
                  prefixIcon: const Icon(Icons.shield_outlined, size: 20),
                  suffixIcon: const Icon(
                    Icons.visibility_off_outlined,
                    size: 20,
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
          ),
          AppSpacing.vGap16,

          SettingsAction(
            safetyTitle: 'Safety Confirmation',
            safetySubtitle:
                'I understand the consequences of forgetting my new password.',
            buttonLabel: 'Update Password',
            isConfirmed: _isConfirmed,
            onConfirmedChanged: (value) {
              setState(() {
                _isConfirmed = value;
              });
            },
            onPressed: () {
              debugPrint('Password Update Pressed!');
            },
          ),
          AppSpacing.vGap32,
        ],
      ),
    );
  }
}
