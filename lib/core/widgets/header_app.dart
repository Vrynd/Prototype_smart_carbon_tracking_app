import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/router/app_router.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

enum HeaderVariant { main, detail }

class HeaderApp extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final double toolbarHeight;
  final Color? backgroundColor;
  final HeaderVariant variant;
  final bool isScrolled;

  const HeaderApp({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle,
    this.toolbarHeight = 66,
    this.backgroundColor,
    this.variant = HeaderVariant.main,
    this.isScrolled = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isScrolled) {
      debugPrint('[HeaderApp] Status: SCROLLED (Solid White)');
    } else {
      debugPrint('[HeaderApp] Status: TOP (Matching Surface)');
    }

    // ... leadingWidget and actionWidgets logic ...
    // (I'll keep the logic in the replacement)
    Widget? leadingWidget;
    if (leading != null) {
      leadingWidget = leading;
    } else {
      switch (variant) {
        case HeaderVariant.main:
          leadingWidget = Padding(
            padding: const EdgeInsets.only(left: 16),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedMenuTwoLine,
              color: context.colors.onSurface,
              size: 16,
            ),
          );
          break;
        case HeaderVariant.detail:
          leadingWidget = GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              margin: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.colors.surfaceContainerLowest.withValues(
                  alpha: .7,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.2,
                  color: isScrolled
                      ? context.colors.outlineVariant.withValues(alpha: 0.6)
                      : context.colors.surfaceContainerLowest,
                ),
              ),
              child: Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowLeft02,
                  color: context.colors.onSurface,
                  size: 24,
                ),
              ),
            ),
          );
          break;
      }
    }

    List<Widget>? actionWidgets;
    if (actions != null) {
      actionWidgets = actions;
    } else {
      switch (variant) {
        case HeaderVariant.main:
          actionWidgets = [
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
          ];
          break;
        case HeaderVariant.detail:
          actionWidgets = [];
          break;
      }
    }

    bool effectiveCenterTitle = centerTitle ?? (variant == HeaderVariant.main);

    // Resolve dynamic title if not provided
    String? resolvedTitle = title;
    if (resolvedTitle == null) {
      final String? routeName = GoRouterState.of(context).name;
      resolvedTitle = AppRouter.getRouteTitle(routeName);
    }

    if (isScrolled) {
      debugPrint('[HeaderApp] Status: SCROLLED (Solid White)');
    } else {
      debugPrint('[HeaderApp] Status: TOP (Matching Surface)');
    }

    return AppBar(
      backgroundColor:
          backgroundColor ??
          (isScrolled
              ? context.colors.surfaceContainerLowest
              : context.colors.surfaceContainerLow),
      toolbarHeight: toolbarHeight,
      leading: leadingWidget,
      leadingWidth: variant == HeaderVariant.detail ? 56 : null,
      title: Text(
        resolvedTitle,
        style: context.text.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: effectiveCenterTitle,
      elevation: isScrolled ? 3 : 0,
      scrolledUnderElevation: 0,
      actions: actionWidgets,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
