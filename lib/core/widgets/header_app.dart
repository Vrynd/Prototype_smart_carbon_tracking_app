import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

class HeaderApp extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final double toolbarHeight;
  final Color? backgroundColor;

  const HeaderApp({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.toolbarHeight = 66,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? context.colors.surfaceContainerLow,
      toolbarHeight: toolbarHeight,
      leading: leading ?? Padding(
        padding: const EdgeInsets.only(left: 16),
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedMenuTwoLine,
          color: context.colors.onSurface,
          size: 16,
        ),
      ),
      title: Text(
        title ?? 'DashBoard',
        style: context.text.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: centerTitle,
      scrolledUnderElevation: 0,
      elevation: 0,
      actions: actions ?? [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=1000&auto=format&fit=crop', // Professional male portrait
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
