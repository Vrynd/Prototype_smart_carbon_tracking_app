import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

enum ActionType { standard, button, text }

class TitleAction extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final String? label;
  final VoidCallback? onTap;
  final dynamic icon;
  final ActionType variant;

  const TitleAction._({
    super.key,
    required this.title,
    this.subtitle,
    this.titleStyle,
    this.label,
    this.onTap,
    this.icon,
    this.variant = ActionType.standard,
  });

  factory TitleAction.standard({
    Key? key,
    required String title,
    String? subtitle,
    TextStyle? titleStyle,
  }) {
    return TitleAction._(
      key: key,
      title: title,
      subtitle: subtitle,
      titleStyle: titleStyle,
      variant: ActionType.standard,
    );
  }

  factory TitleAction.button({
    Key? key,
    required String title,
    String? subtitle,
    dynamic icon,
    VoidCallback? onTap,
    TextStyle? titleStyle,
  }) {
    return TitleAction._(
      key: key,
      title: title,
      subtitle: subtitle,
      icon: icon,
      onTap: onTap,
      titleStyle: titleStyle,
      variant: ActionType.button,
    );
  }

  factory TitleAction.text({
    Key? key,
    required String title,
    required String label,
    VoidCallback? onTap,
    String? subtitle,
    TextStyle? titleStyle,
  }) {
    return TitleAction._(
      key: key,
      title: title,
      subtitle: subtitle,
      label: label,
      onTap: onTap,
      titleStyle: titleStyle,
      variant: ActionType.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_buildTitle(context), _buildAction(context)],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style:
              titleStyle ??
              context.text.titleLarge?.copyWith(
                color: context.colors.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: context.text.titleSmall?.copyWith(
              color: context.colors.outline.withValues(alpha: 0.8),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAction(BuildContext context) {
    return switch (variant) {
      ActionType.button => _buildIconButton(context),
      ActionType.text => _buildTextButton(context),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildIconButton(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: context.colors.primary,
        minimumSize: const Size(0, 36),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      child: HugeIcon(
        icon: icon ?? HugeIcons.strokeRoundedArrowRight01,
        color: context.colors.onPrimary,
        size: 24,
      ),
    );
  }

  Widget _buildTextButton(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label ?? "See All",
        style: context.text.bodyMedium?.copyWith(
          color: context.colors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
