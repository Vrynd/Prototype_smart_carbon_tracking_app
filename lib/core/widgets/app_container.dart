import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

enum ContainerVariant {
  basic,
  compact,
  custom,
}

class AppContainer extends StatelessWidget {
  final Widget? child;
  final List<Widget>? children;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? spacing;
  final ContainerVariant variant;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool showBorder;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;

  const AppContainer({
    super.key,
    this.child,
    this.children,
    this.padding,
    this.margin,
    this.spacing,
    this.variant = ContainerVariant.basic,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.showBorder = true,
    this.width,
    this.height,
    this.alignment,
    this.constraints,
    this.boxShadow,
    this.gradient,
  }) : assert(child == null || children == null, 'Cannot provide both child and children');

  const AppContainer.compact({
    super.key,
    this.child,
    this.children,
    this.padding,
    this.margin,
    this.spacing,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.showBorder = true,
    this.width = double.infinity,
    this.height,
    this.alignment,
    this.constraints,
    this.boxShadow,
    this.gradient,
  })  : variant = ContainerVariant.compact,
        assert(child == null || children == null, 'Cannot provide both child and children');

  const AppContainer.custom({
    super.key,
    this.child,
    this.children,
    this.padding,
    this.margin,
    this.spacing,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.showBorder = true,
    this.width,
    this.height,
    this.alignment,
    this.constraints,
    this.boxShadow,
    this.gradient,
  })  : variant = ContainerVariant.custom,
        assert(child == null || children == null, 'Cannot provide both child and children');

  @override
  Widget build(BuildContext context) {
    final bool isCompact = variant == ContainerVariant.compact;
    final bool isCustom = variant == ContainerVariant.custom;

    final double effectiveSpacing = spacing ?? (isCompact ? 8.0 : 24.0);
    
    final double effectiveRadius = borderRadius ?? 
        (isCompact ? 16.0 : (isCustom ? 0.0 : 24.0));
    
    final EdgeInsetsGeometry effectivePadding = padding ?? 
        EdgeInsets.all(isCompact ? 16.0 : 20.0);
    
    final Color effectiveBgColor = backgroundColor ?? 
        context.colors.surfaceContainerLowest.withValues(
          alpha: isCompact ? 0.7 : 0.8,
        );

    final Border? effectiveBorder = showBorder
        ? Border.all(
            color: borderColor ?? (isCustom ? context.colors.outlineVariant : context.colors.surfaceContainerLowest),
            width: isCustom ? 1.0 : 1.2,
          )
        : null;

    final Widget? content = children != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: effectiveSpacing,
            children: children!,
          )
        : child;

    return Container(
      width: width,
      height: height,
      margin: margin,
      alignment: alignment,
      constraints: constraints,
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(effectiveRadius),
        border: effectiveBorder,
        boxShadow: boxShadow,
        gradient: gradient,
      ),
      child: content,
    );
  }
}
