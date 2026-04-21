// ignore_for_file: unused_field

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:yir_text_form_field/paints/card_paint.dart';

// ─────────────────────────────────────────────
//  YirTextFormField - Main Text Form Field Widget
// ─────────────────────────────────────────────
class YirTextFormField extends StatefulWidget {
  /// Required: Text editing controller
  final TextEditingController controller;

  /// Required: Hint text
  final String hint;

  /// Optional: Input label text
  final String? label;

  /// Optional: Text input type
  final TextInputType keyboardType;

  /// Optional: Maximum lines
  final int? maxLines;

  /// Optional: Minimum lines
  final int? minLines;

  /// Optional: Blur effect intensity
  final double blur;

  /// Optional: Enable glow pulse animation on border
  final bool enableGlowPulse;

  /// Optional: Enable shimmer sweep animation
  final bool enableShimmer;

  /// Optional: Enable floating/breathing animation
  final bool enableFloat;

  /// Optional: Enable tap effect (ripple + scale)
  final bool enableTapEffect;

  /// Optional: Animation speed multiplier
  final double animationSpeed;

  /// Optional: Input decoration customization
  final InputDecoration? decoration;

  /// Optional: Text style
  final TextStyle? style;

  /// Optional: Icon at start
  final Widget? prefixIcon;

  /// Optional: Icon at end
  final Widget? suffixIcon;

  /// Optional: Validator function
  final String? Function(String?)? validator;

  /// Optional: On change callback
  final void Function(String)? onChanged;

  /// Optional: On submit callback
  final void Function(String)? onSubmitted;

  const YirTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines,
    this.blur = 12,
    this.enableGlowPulse = true,
    this.enableShimmer = true,
    this.enableFloat = true,
    this.enableTapEffect = true,
    this.animationSpeed = 1.0,
    this.decoration,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<YirTextFormField> createState() => _YirTextFormFieldState();
}

class _YirTextFormFieldState extends State<YirTextFormField>
    with TickerProviderStateMixin {
  // ── Animation Controllers ─────────────────
  late final AnimationController _glowCtrl;
  late final AnimationController _shimmerCtrl;
  late final AnimationController _floatCtrl;
  late final AnimationController _tapCtrl;

  // ── Animations ────────────────────────────
  late final Animation<double> _glowAnim;
  late final Animation<double> _shimmerAnim;
  late final Animation<double> _floatAnim;
  late final Animation<double> _tapScaleAnim;

  bool _isFocused = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    final s = widget.animationSpeed;

    // 1. Glow pulse – border opacity breathes
    _glowCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (2000 / s).round()),
    )..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    // 2. Shimmer – sweeps a bright line
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (2800 / s).round()),
    )..repeat();
    _shimmerAnim = CurvedAnimation(parent: _shimmerCtrl, curve: Curves.linear);

    // 3. Float – subtle Y-axis breathing
    _floatCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (3200 / s).round()),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    // 4. Tap – scale bounce
    _tapCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (300 / s).round()),
    );
    _tapScaleAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.98), weight: 30),
      TweenSequenceItem(
        tween: Tween(begin: 0.98, end: 1.02)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 70,
      ),
    ]).animate(_tapCtrl);
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    _shimmerCtrl.dispose();
    _floatCtrl.dispose();
    _tapCtrl.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (!widget.enableTapEffect) return;
    setState(() => _isPressed = true);
    _tapCtrl.forward(from: 0);
  }

  void _onTapUp(TapUpDetails _) => setState(() => _isPressed = false);
  void _onTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    // Create the input decoration
    final defaultDecoration = InputDecoration(
      hintText: widget.hint,
      labelText: widget.label,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
    );

    final decoration = widget.decoration ?? defaultDecoration;

    // Build the text form field
    Widget textField = ClipPath(
      clipper: RPSPaintField(),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: widget.blur,
          sigmaY: widget.blur,
        ),
        child: Stack(
          children: [
             
            // Border and glow painter
            if (widget.enableGlowPulse)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _glowAnim,
                  builder: (_, __) => CustomPaint(
                    painter: RPSCustomPainter(opacity: _glowAnim.value),
                  ),
                ),
              )
            else
              Positioned.fill(
                child: CustomPaint(
                  painter: const RPSCustomPainter(opacity: 0.6),
                ),
              ),
        
            // Shimmer sweep
            if (widget.enableShimmer)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _shimmerAnim,
                  builder: (_, __) => CustomPaint(
                    painter: _ShimmerPainter(progress: _shimmerAnim.value),
                  ),
                ),
              ),
        
            // Text form field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextFormField(
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                style: widget.style ??
                    const TextStyle(color: Colors.white, fontSize: 14),
                decoration: decoration.copyWith(
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                validator: widget.validator,
                onChanged: widget.onChanged,
                onFieldSubmitted: widget.onSubmitted,
                onTap: () => setState(() => _isFocused = true),
                onTapOutside: (_) => setState(() => _isFocused = false),
              ),
            ),
          ],
        ),
      ),
    );

    // Wrap with float animation
    if (widget.enableFloat) {
      textField = AnimatedBuilder(
        animation: _floatAnim,
        builder: (_, child) => Transform.translate(
          offset: Offset(0, _floatAnim.value),
          child: child,
        ),
        child: textField,
      );
    }

    // Wrap with tap scale animation
    if (widget.enableTapEffect) {
      textField = GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedBuilder(
          animation: _tapScaleAnim,
          builder: (_, child) => Transform.scale(
            scale: _tapScaleAnim.value,
            child: child,
          ),
          child: textField,
        ),
      );
    }

    return textField;
  }
}

// ─────────────────────────────────────────────
//  Shimmer Painter
// ─────────────────────────────────────────────
class _ShimmerPainter extends CustomPainter {
  final double progress;

  _ShimmerPainter({required this.progress});

  Path _buildPath(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.9976415, size.height * 0.01219512);
    path.lineTo(size.width * 0.9976415, size.height * 0.8127854);
    path.lineTo(size.width * 0.9705660, size.height * 0.9878049);
    path.lineTo(size.width * 0.002358491, size.height * 0.9878049);
    path.lineTo(size.width * 0.002358491, size.height * 0.1030393);
    path.lineTo(size.width * 0.02212467, size.height * 0.01219512);
    path.lineTo(size.width * 0.9976415, size.height * 0.01219512);
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;

    final total = metrics.fold<double>(0, (sum, m) => sum + m.length);
    const arcLength = 80.0;
    final headPos = total * progress;

    for (final metric in metrics) {
      final start = metric.length * (headPos / total) - arcLength / 2;
      final extractStart = start.clamp(0.0, metric.length);
      final extractEnd = (start + arcLength).clamp(0.0, metric.length).toDouble();
      if (extractEnd <= extractStart) continue;

      final arcPath = metric.extractPath(extractStart, extractEnd);

      canvas.drawPath(
        arcPath,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.12)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );

      canvas.drawPath(
        arcPath,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(_ShimmerPainter old) => old.progress != progress;
}