import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// BankX brand logo using the official asset with optional entrance animations.
class BankXLogo extends StatefulWidget {
  const BankXLogo({
    super.key,
    this.size = 200,
    this.showText = true,
    this.animate = false,
  });

  final double size;
  final bool showText;
  final bool animate;

  static const _assetPath = 'assets/images/bankx_logo.png';

  @override
  State<BankXLogo> createState() => _BankXLogoState();
}

class _BankXLogoState extends State<BankXLogo> with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _shimmerController;
  late final AnimationController _glowController;

  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    _scaleAnimation = Tween<double>(begin: 0.65, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.75, curve: Curves.easeOutBack),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 24.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.15, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    if (widget.animate) {
      _entranceController.forward();
      _shimmerController.repeat();
      _glowController.repeat(reverse: true);
    } else {
      _entranceController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(BankXLogo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      _entranceController.forward(from: 0);
      _shimmerController.repeat();
      _glowController.repeat(reverse: true);
    } else if (!widget.animate && oldWidget.animate) {
      _entranceController.value = 1.0;
      _shimmerController.stop();
      _glowController.stop();
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _shimmerController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      BankXLogo._assetPath,
      width: widget.size,
      height: widget.size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.medium,
    );

    if (!widget.animate) {
      return logo;
    }

    return AnimatedBuilder(
      animation: Listenable.merge([
        _entranceController,
        _shimmerController,
        _glowController,
      ]),
      builder: (context, child) {
        final glowOpacity = 0.25 + (_glowController.value * 0.35);
        final glowScale = 1.0 + (_glowController.value * 0.12);
        final shimmerOffset =
            (_shimmerController.value * widget.size * 2.2) - widget.size * 0.6;

        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Transform.scale(
                    scale: glowScale,
                    child: Container(
                      width: widget.size * 0.85,
                      height: widget.size * 0.85,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryBlue.withValues(
                              alpha: glowOpacity,
                            ),
                            blurRadius: 48,
                            spreadRadius: 8,
                          ),
                          BoxShadow(
                            color: AppColors.accentCyan.withValues(
                              alpha: glowOpacity * 0.6,
                            ),
                            blurRadius: 64,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  child!,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(widget.size * 0.08),
                    child: SizedBox(
                      width: widget.size,
                      height: widget.size,
                      child: Stack(
                        children: [
                          Positioned(
                            left: shimmerOffset,
                            top: 0,
                            bottom: 0,
                            width: widget.size * 0.35,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.transparent,
                                    AppColors.accentCyan.withValues(
                                      alpha: 0.0,
                                    ),
                                    AppColors.accentCyan.withValues(
                                      alpha: 0.35,
                                    ),
                                    Colors.white.withValues(alpha: 0.25),
                                    AppColors.accentCyan.withValues(
                                      alpha: 0.35,
                                    ),
                                    AppColors.accentCyan.withValues(
                                      alpha: 0.0,
                                    ),
                                    Colors.transparent,
                                  ],
                                  stops: const [
                                    0.0,
                                    0.15,
                                    0.35,
                                    0.5,
                                    0.65,
                                    0.85,
                                    1.0,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: logo,
    );
  }
}

/// Animated ambient background orbs for splash / hero sections.
class BankXLogoBackground extends StatefulWidget {
  const BankXLogoBackground({super.key, required this.child});

  final Widget child;

  @override
  State<BankXLogoBackground> createState() => _BankXLogoBackgroundState();
}

class _BankXLogoBackgroundState extends State<BankXLogoBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value * 2 * math.pi;

        return Stack(
          fit: StackFit.expand,
          children: [
            Container(color: AppColors.darkBackground),
            _Orb(
              color: AppColors.primaryBlue.withValues(alpha: 0.18),
              size: 280,
              offset: Offset(
                math.cos(t) * 30 - 80,
                math.sin(t * 0.8) * 40 - 120,
              ),
            ),
            _Orb(
              color: AppColors.accentCyan.withValues(alpha: 0.12),
              size: 220,
              offset: Offset(
                math.sin(t * 0.9) * 35 + 100,
                math.cos(t * 0.7) * 45 + 140,
              ),
            ),
            _Orb(
              color: AppColors.primaryDark.withValues(alpha: 0.25),
              size: 320,
              offset: Offset(
                math.cos(t * 0.6 + 1) * 20,
                math.sin(t * 0.5 + 2) * 25 + 60,
              ),
            ),
            child!,
          ],
        );
      },
      child: widget.child,
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({
    required this.color,
    required this.size,
    required this.offset,
  });

  final Color color;
  final double size;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Transform.translate(
        offset: offset,
        child: Center(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [color, color.withValues(alpha: 0)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
