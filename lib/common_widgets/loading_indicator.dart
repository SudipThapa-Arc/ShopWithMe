import 'package:flutter/material.dart';
import 'package:shopwithme/design_system/colors.dart';

class LoadingIndicator extends StatelessWidget {
  final Color color;
  final double size;
  final double strokeWidth;

  const LoadingIndicator({
    super.key,
    this.color = AppColors.primary,
    this.size = 24.0,
    this.strokeWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textColor;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const LoadingButton({
    super.key,
    required this.isLoading,
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
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBackgroundColor: color.withOpacity(0.7),
          disabledForegroundColor: textColor.withOpacity(0.7),
        ),
        child: isLoading
            ? LoadingIndicator(
                color: textColor,
                size: height * 0.5,
              )
            : child,
      ),
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LoadingIndicator(
                    color: Colors.white,
                    size: 48.0,
                  ),
                  if (message != null) ...[
                    const SizedBox(height: 16.0),
                    Text(
                      message!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
} 