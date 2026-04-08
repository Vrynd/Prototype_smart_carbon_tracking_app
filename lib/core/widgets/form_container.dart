import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

class FormContainer extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final double gap;

  const FormContainer({
    super.key,
    required this.children,
    this.padding,
    this.gap = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.colors.surfaceContainerLowest,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1) SizedBox(height: gap),
          ],
        ],
      ),
    );
  }
}
