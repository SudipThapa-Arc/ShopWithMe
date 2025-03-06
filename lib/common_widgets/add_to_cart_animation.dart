import 'package:flutter/material.dart';

class AddToCartAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Offset startPosition;
  final Offset endPosition;

  const AddToCartAnimation({
    super.key,
    required this.child,
    required this.onPressed,
    required this.startPosition,
    required this.endPosition,
  });

  @override
  State<AddToCartAnimation> createState() => _AddToCartAnimationState();
}

class _AddToCartAnimationState extends State<AddToCartAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _moveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    _moveAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.fastOutSlowIn),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onPressed();
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double dx = widget.startPosition.dx +
            (widget.endPosition.dx - widget.startPosition.dx) * _moveAnimation.value;
        final double dy = widget.startPosition.dy +
            (widget.endPosition.dy - widget.startPosition.dy) * _moveAnimation.value;

        return Positioned(
          left: dx,
          top: dy,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTap: _startAnimation,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
} 