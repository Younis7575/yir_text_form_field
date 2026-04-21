import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  RPSCustomPainter – Text Form Field Design
// ─────────────────────────────────────────────
class RPSCustomPainter extends CustomPainter {
  final double opacity;

  const RPSCustomPainter({this.opacity = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.009192048, size.height * 0.1);
    path_0.lineTo(size.width * 0.1875907, size.height * 0);
    path_0.lineTo(size.width * 0.9433645, size.height * 0);
    path_0.lineTo(size.width * 0.9993916, size.height * 0.15);
    path_0.lineTo(size.width * 0.9993916, size.height * 0.85);
    path_0.lineTo(size.width * 0.9433645, size.height);
    path_0.lineTo(size.width * 0.1875907, size.height);
    path_0.lineTo(size.width * 0.009192048, size.height * 0.9);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff777777).withValues(alpha: opacity * 0.3);
    canvas.drawPath(path_0, paint_0_fill);

    // Border
    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    paint_0_stroke.color = Color(0xffffffff).withValues(alpha: opacity * 0.6);
    canvas.drawPath(path_0, paint_0_stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ─────────────────────────────────────────────
//  RPSPaintContainer – Shape Clipper
// ─────────────────────────────────────────────
class RPSPaintContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.009192048, size.height * 0.1);
    path_0.lineTo(size.width * 0.1875907, size.height * 0);
    path_0.lineTo(size.width * 0.9433645, size.height * 0);
    path_0.lineTo(size.width * 0.9993916, size.height * 0.15);
    path_0.lineTo(size.width * 0.9993916, size.height * 0.85);
    path_0.lineTo(size.width * 0.9433645, size.height);
    path_0.lineTo(size.width * 0.1875907, size.height);
    path_0.lineTo(size.width * 0.009192048, size.height * 0.9);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

