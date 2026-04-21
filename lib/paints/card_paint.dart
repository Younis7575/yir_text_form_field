
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  RPSPaintField – Clipper for text form field
// ─────────────────────────────────────────────
class RPSPaintField extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    
    path_0.moveTo(size.width * 0.9976415, size.height * 0.01219512);
    path_0.lineTo(size.width * 0.9976415, size.height * 0.8127854);
    path_0.lineTo(size.width * 0.9705660, size.height * 0.9878049);
    path_0.lineTo(size.width * 0.002358491, size.height * 0.9878049);
    path_0.lineTo(size.width * 0.002358491, size.height * 0.1030393);
    path_0.lineTo(size.width * 0.02212467, size.height * 0.01219512);
    path_0.lineTo(size.width * 0.9976415, size.height * 0.01219512);
    path_0.close();
    
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ─────────────────────────────────────────────
//  RPSCustomPainter – Border and glow painter
// ─────────────────────────────────────────────
class RPSCustomPainter extends CustomPainter {
  final double opacity;

  const RPSCustomPainter({this.opacity = 1.0});

  Path _buildPath(Size size) {
    Path path_0 = Path();
    
    path_0.moveTo(size.width * 0.9976415, size.height * 0.01219512);
    path_0.lineTo(size.width * 0.9976415, size.height * 0.8127854);
    path_0.lineTo(size.width * 0.9705660, size.height * 0.9878049);
    path_0.lineTo(size.width * 0.002358491, size.height * 0.9878049);
    path_0.lineTo(size.width * 0.002358491, size.height * 0.1030393);
    path_0.lineTo(size.width * 0.02212467, size.height * 0.01219512);
    path_0.lineTo(size.width * 0.9976415, size.height * 0.01219512);
    path_0.close();
    
    return path_0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);

    // Fill layer
    // ignore: non_constant_identifier_names
    Paint paint_fill = Paint()..style = PaintingStyle.fill;
    paint_fill.color = const Color(0xff777777).withValues(alpha: opacity * 0.15);
    canvas.drawPath(path, paint_fill);

    // Outer glow
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white.withValues(alpha: opacity * 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    // Main border stroke
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color.fromARGB(255, 255, 255, 255).withValues(alpha: opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant RPSCustomPainter oldDelegate) =>
      oldDelegate.opacity != opacity;
}