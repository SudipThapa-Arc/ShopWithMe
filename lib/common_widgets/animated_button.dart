import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:shopwithme/design_system/colors.dart';

class AnimatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textColor;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const AnimatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = AppColors.primary,
    this.textColor = AppColors.onPrimary,
    this.height = 48.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OpenContainer(
        transitionDuration: const Duration(milliseconds: 300),
        openBuilder: (context, _) => const SizedBox.shrink(),
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        closedColor: color,
        closedElevation: 0,
        closedBuilder: (context, openContainer) {
          return InkWell(
            onTap: () {
              onPressed();
            },
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Center(
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  child: child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final Color backgroundColor;
  final double size;

  const AnimatedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color = AppColors.primary,
    this.backgroundColor = Colors.transparent,
    this.size = 24.0,
  });

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.icon,
                color: widget.color,
                size: widget.size,
              ),
            ),
          );
        },
      ),
    );
  }
} 