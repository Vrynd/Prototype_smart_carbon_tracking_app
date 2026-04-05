import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

class DashedDivider extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashSpace;
  final Color? color;
  final double indent;
  final double endIndent;

  const DashedDivider({
    super.key,
    this.height = .5,
    this.dashWidth = 4.0,
    this.dashSpace = 4.0,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Padding(
          padding: EdgeInsets.only(left: indent, right: endIndent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: height,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: color ?? context.colors.outlineVariant,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
