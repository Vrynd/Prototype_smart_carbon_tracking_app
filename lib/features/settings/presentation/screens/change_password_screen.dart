import 'package:flutter/material.dart' hide Hero;
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/settings/settings.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

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
                  HeroHeader(
                    icon: HugeIcons.strokeRoundedPasswordValidation,
                    title: 'Create Strong Password',
                    variant: HeroVariant.modern,
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

  void _onUpdatePressed(
    BuildContext context,
    ChangePasswordController controller,
  ) async {
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );

      Navigator.of(context).pop();
    }
  }
}
