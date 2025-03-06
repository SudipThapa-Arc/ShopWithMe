import 'package:flutter/material.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/borders.dart';
import 'package:shopwithme/design_system/elevation.dart';
import 'package:shopwithme/design_system/spacing.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final List<BoxShadow>? elevation;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(Spacing.md),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.surface,
          borderRadius: borderRadius ?? AppBorders.roundedMd,
          boxShadow: elevation ?? Elevation.low,
        ),
        child: child,
      ),
    );
  }

  // Factory constructors for common card variants
  factory AppCard.elevated({
    required Widget child,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    VoidCallback? onTap,
  }) {
    return AppCard(
      padding: padding,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      elevation: Elevation.medium,
      onTap: onTap,
      child: child,
    );
  }

  factory AppCard.flat({
    required Widget child,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    VoidCallback? onTap,
  }) {
    return AppCard(
      padding: padding,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      elevation: Elevation.none,
      onTap: onTap,
      child: child,
    );
  }
} 