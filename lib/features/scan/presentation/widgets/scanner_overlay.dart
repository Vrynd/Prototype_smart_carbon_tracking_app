import 'package:flutter/material.dart';

class ScannerOverlay extends StatefulWidget {
  const ScannerOverlay({super.key});

  @override
  State<ScannerOverlay> createState() => _ScannerOverlayState();
}

class _ScannerOverlayState extends State<ScannerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: _ScannerPainter(
            scanProgress: _animation.value,
            primaryColor: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}

class _ScannerPainter extends CustomPainter {
  final double scanProgress;
  final Color primaryColor;

  _ScannerPainter({required this.scanProgress, required this.primaryColor});

  @override
  void paint(Canvas canvas, Size size) {
    final double scanAreaWidth = size.width * 0.75;
    final double scanAreaHeight = scanAreaWidth;
    final double left = (size.width - scanAreaWidth) / 2;
    final double top = (size.height - scanAreaHeight) / 2.5;
    final Rect scanRect = Rect.fromLTWH(left, top, scanAreaWidth, scanAreaHeight);

    final Paint maskPaint = Paint()..color = Colors.black.withValues(alpha: 0.6);
    final Path maskPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(32)))
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(maskPath, maskPaint);

    final Paint cornerPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    const double cornerSize = 40;
    const double radius = 32;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(left + radius, top + radius), radius: radius),
      3.14,
      1.57 / 2,
      false,
      cornerPaint,
    );
    canvas.drawLine(Offset(left, top + radius), Offset(left, top + radius + cornerSize), cornerPaint);
    canvas.drawLine(Offset(left + radius, top), Offset(left + radius + cornerSize, top), cornerPaint);

    canvas.drawArc(
      Rect.fromCircle(center: Offset(left + scanAreaWidth - radius, top + radius), radius: radius),
      -1.57,
      1.57 / 2,
      false,
      cornerPaint,
    );
    canvas.drawLine(Offset(left + scanAreaWidth, top + radius), Offset(left + scanAreaWidth, top + radius + cornerSize), cornerPaint);
    canvas.drawLine(Offset(left + scanAreaWidth - radius, top), Offset(left + scanAreaWidth - radius - cornerSize, top), cornerPaint);

    canvas.drawArc(
      Rect.fromCircle(center: Offset(left + radius, top + scanAreaHeight - radius), radius: radius),
      1.57,
      1.57 / 2,
      false,
      cornerPaint,
    );
    canvas.drawLine(Offset(left, top + scanAreaHeight - radius), Offset(left, top + scanAreaHeight - radius - cornerSize), cornerPaint);
    canvas.drawLine(Offset(left + radius, top + scanAreaHeight), Offset(left + radius + cornerSize, top + scanAreaHeight), cornerPaint);

    canvas.drawArc(
      Rect.fromCircle(center: Offset(left + scanAreaWidth - radius, top + scanAreaHeight - radius), radius: radius),
      0,
      1.57 / 2,
      false,
      cornerPaint,
    );
    canvas.drawLine(Offset(left + scanAreaWidth, top + scanAreaHeight - radius), Offset(left + scanAreaWidth, top + scanAreaHeight - radius - cornerSize), cornerPaint);
    canvas.drawLine(Offset(left + scanAreaWidth - radius, top + scanAreaHeight), Offset(left + scanAreaWidth - radius - cornerSize, top + scanAreaHeight), cornerPaint);

    final double laserY = top + (scanAreaHeight * scanProgress);
    final Paint laserPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          primaryColor.withValues(alpha: 0),
          primaryColor,
          primaryColor.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromLTWH(left, laserY - 1, scanAreaWidth, 2));

    canvas.drawRect(Rect.fromLTWH(left + 20, laserY, scanAreaWidth - 40, 2), laserPaint);

    final Paint glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          primaryColor.withValues(alpha: 0.3),
          primaryColor.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(size.width / 2, laserY), radius: 50));
    canvas.drawRect(Rect.fromLTWH(left, laserY - 20, scanAreaWidth, 40), glowPaint);
  }

  @override
  bool shouldRepaint(covariant _ScannerPainter oldDelegate) => true;
}
