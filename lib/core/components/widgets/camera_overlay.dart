import 'package:flutter/material.dart';

class CameraOverlay extends StatelessWidget {
  final double scanAreaWidth;
  final double scanAreaHeight;
  final double cornerLength;
  final double cornerThickness;
  final Color cornerColor;
  final double cornerRadius;

  const CameraOverlay({
    super.key,
    required this.scanAreaWidth,
    required this.scanAreaHeight,
    required this.cornerLength,
    required this.cornerThickness,
    required this.cornerColor,
    required this.cornerRadius,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(scanAreaWidth, scanAreaHeight),
      painter: CornerBorderPainter(
        cornerLength: cornerLength,
        cornerThickness: cornerThickness,
        cornerColor: cornerColor,
        cornerRadius: cornerRadius,
      ),
    );
  }
}

class CornerBorderPainter extends CustomPainter {
  final double cornerLength;
  final double cornerThickness;
  final Color cornerColor;
  final double cornerRadius;

  CornerBorderPainter({
    required this.cornerLength,
    required this.cornerThickness,
    required this.cornerColor,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = cornerColor
      ..strokeWidth = cornerThickness
      ..style = PaintingStyle.stroke;

    _drawCorner(canvas, paint, const Offset(0, 0), 0);

    _drawCorner(canvas, paint, Offset(size.width, 0), 90);

    _drawCorner(canvas, paint, Offset(0, size.height), 270);

    _drawCorner(canvas, paint, Offset(size.width, size.height), 180);
  }

  void _drawCorner(
      Canvas canvas, Paint paint, Offset position, double rotationAngle) {
    canvas.save();

    canvas.translate(position.dx, position.dy);

    canvas.rotate(rotationAngle * 3.14159265359 / 180);

    final path = Path();

    path.moveTo(0, cornerRadius);
    path.arcTo(
      Rect.fromLTWH(0, 0, cornerRadius * 2, cornerRadius * 2),
      3.14,
      1.57,
      false,
    );

    canvas.drawPath(path, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}