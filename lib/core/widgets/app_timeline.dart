import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

enum TimelineStyle { solid, dashed }

class AppTimeline extends StatelessWidget {
  final Widget child;
  final bool isLast;
  final Color dotColor;
  final Color? lineColor;
  final bool showGlow;
  final TimelineStyle style;

  const AppTimeline({
    super.key,
    required this.child,
    this.isLast = false,
    required this.dotColor,
    this.lineColor,
    this.showGlow = false,
    this.style = TimelineStyle.solid,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: dotColor,
                      width: 2.2,
                    ),
                    boxShadow: [
                      if (showGlow)
                        BoxShadow(
                          color: dotColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                
                // Timeline Line
                if (!isLast)
                  Expanded(
                    child: style == TimelineStyle.solid
                        ? Container(
                            width: 2,
                            color: lineColor ?? Colors.grey[200],
                          )
                        : CustomPaint(
                            size: const Size(2, double.infinity),
                            painter: _DashedLinePainter(
                              color: lineColor ?? Colors.grey[300]!,
                            ),
                          ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;

  const _DashedLinePainter({
    required this.color,
  });

  static const double dashHeight = 5;
  static const double dashGap = 3;
  static const double strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    double startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashGap;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

