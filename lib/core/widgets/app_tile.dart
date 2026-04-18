import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

enum TileVariant { classic, modern }

class AppTile extends StatelessWidget {
  final dynamic icon;
  final String title;
  final String? subtitle;
  final String? value;
  final TileVariant variant;
  final Color? iconColor;
  final Color? valueColor;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDanger;

  const AppTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.value,
    this.variant = TileVariant.modern,
    this.iconColor,
    this.valueColor,
    this.trailing,
    this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == TileVariant.classic) {
      return _buildClassic(context);
    }
    return _buildModern(context);
  }

  Widget _buildClassic(BuildContext context) {
    final Color effectiveColor = isDanger
        ? Colors.redAccent
        : (iconColor ?? context.colors.primary);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: effectiveColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: HugeIcon(icon: icon, color: effectiveColor, size: 20),
              ),
              AppSpacing.hGap16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.text.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDanger
                            ? Colors.redAccent
                            : context.colors.onSurface,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: context.text.labelSmall?.copyWith(
                          color: context.colors.onSurfaceVariant.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
              if (onTap != null && trailing == null)
                Icon(
                  Icons.chevron_right_rounded,
                  color: context.colors.onSurfaceVariant.withValues(alpha: 0.3),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModern(BuildContext context) {
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
      trailing:
          trailing ??
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
