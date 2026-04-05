import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

class SettingTile extends StatelessWidget {
  final dynamic icon;
  final String title;
  final String? value;
  final Color? iconColor;
  final Color? valueColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.iconColor,
    this.valueColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      leading: HugeIcon(
        icon: icon,
        color: iconColor ?? context.colors.onSurfaceVariant,
        size: 20,
      ),
      title: Text(
        title,
        style: context.text.titleSmall?.copyWith(
          color: context.colors.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: trailing ??
          (value != null
              ? Text(
                  value!,
                  style: context.text.labelMedium?.copyWith(
                    color: valueColor ?? context.colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : const HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowRight02,
                  size: 16,
                )),
    );
  }
}
