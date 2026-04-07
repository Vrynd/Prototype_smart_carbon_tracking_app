import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/app_loading.dart';
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
  String _newPassword = '';

  Future<void> _handleUpdatePassword() async {
    AppLoading.show(context, message: 'Updating your password...');

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    AppLoading.hide(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: context.colors.surfaceContainerHighest,
              size: 20,
            ),
            AppSpacing.hGap12,
            const Text('Password updated successfully!'),
          ],
        ),
        backgroundColor: context.colors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );

    // 5. Kembali ke halaman sebelumnya
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldApp(
      backgroundColor: context.colors.surfaceContainerLow,
      appBar: const HeaderApp(
        title: 'Change Password',
        variant: HeaderVariant.detail,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
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
            onNewPasswordChanged: (value) {
              setState(() => _newPassword = value);
            },
          ),

          AppSpacing.vGap32,
        ],
      ),
      bottomNavigationBar: SettingsAction(
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
        // Tombol hanya aktif jika dikonfirmasi DAN password baru tidak kosong
        onPressed: (_isConfirmed && _newPassword.isNotEmpty)
            ? _handleUpdatePassword
            : null,
      ),
    );
  }
}
