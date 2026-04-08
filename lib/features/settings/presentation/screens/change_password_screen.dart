import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/header_app.dart';
import 'package:smart_carbon_tracking/core/widgets/scaffold_app.dart';
import 'package:smart_carbon_tracking/features/settings/controllers/change_password_controller.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/widgets/bar_action.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/widgets/change_password_form.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/widgets/header_info.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  void _onUpdatePressed(
      BuildContext context, ChangePasswordController controller) async {
    final success = await controller.updatePassword(context);

    if (success && context.mounted) {
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChangePasswordController(),
      child: Consumer<ChangePasswordController>(
        builder: (context, controller, child) {
          return ScaffoldApp(
            backgroundColor: context.colors.surfaceContainerLow,
            appBar: const HeaderApp(
              title: 'Change Password',
              variant: HeaderVariant.detail,
            ),
            body: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(
                overscroll: false,
                physics: const BouncingScrollPhysics(),
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                children: [
                  const HeaderInfo(
                    icon: Icons.lock_reset_rounded,
                    title: 'Create Strong Password',
                    variant: HeaderStyle.modern,
                    subtitle:
                        'Your new password must be different\nfrom previous used passwords.',
                  ),
                  AppSpacing.vGap16,
                  
                  const ChangePasswordForm(),
                ],
              ),
            ),
            bottomNavigationBar: BarAction(
              safetyTitle: 'Safety Confirmation',
              safetySubtitle:
                  'I understand the consequences of forgetting my new password.',
              buttonLabel: 'Update Password',
              isConfirmed: controller.isConfirmed,
              onConfirmedChanged: (value) => controller.setConfirmed(value),
              onPressed: controller.canUpdate
                  ? () => _onUpdatePressed(context, controller)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
