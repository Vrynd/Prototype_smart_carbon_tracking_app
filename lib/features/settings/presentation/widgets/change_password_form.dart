import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_carbon_tracking/core/widgets/form_container.dart';
import 'package:smart_carbon_tracking/core/widgets/input_field.dart';
import 'package:smart_carbon_tracking/features/settings/controllers/change_password_controller.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/widgets/password_strength_indicator.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ChangePasswordController>();

    return FormContainer(
      children: [
        const InputField(
          label: 'Current Password',
          hintText: 'Enter current password',
          variant: InputType.password,
          prefixIcon: Icons.lock_outline_rounded,
        ),
        InputField(
          label: 'New Password',
          hintText: 'Enter new password',
          variant: InputType.password,
          prefixIcon: Icons.vpn_key_outlined,
          onChanged: (value) => controller.setNewPassword(value),
        ),
        Transform.translate(
          offset: const Offset(0, -8),
          child: PasswordStrengthIndicator(
            score: controller.passwordScore,
            password: controller.newPassword,
            hasMinLength: controller.hasMinLength,
            hasUpperLower: controller.hasUpperLower,
            hasDigit: controller.hasDigit,
            hasSpecialChar: controller.hasSpecialChar,
          ),
        ),
        const InputField(
          label: 'Confirm New Password',
          hintText: 'Retype new password',
          variant: InputType.password,
          prefixIcon: Icons.shield_outlined,
        ),
      ],
    );
  }
}
