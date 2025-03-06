import 'package:flutter/material.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/borders.dart';
import 'package:shopwithme/design_system/spacing.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final ButtonStyle? style;
  final ButtonType type;
  final ButtonSize size;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.style,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: style ?? type.style,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: size.iconSize),
          SizedBox(width: Spacing.xs),
          Text(text, style: size.textStyle),
        ],
      );
    }

    return Text(text, style: size.textStyle);
  }
}

enum ButtonType {
  primary,
  secondary,
  outline,
  text;

  ButtonStyle get style {
    switch (this) {
      case ButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: AppBorders.roundedSm),
          elevation: 0,
        );
      case ButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.onSecondary,
          shape: RoundedRectangleBorder(borderRadius: AppBorders.roundedSm),
          elevation: 0,
        );
      case ButtonType.outline:
        return OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: AppBorders.roundedSm),
        );
      case ButtonType.text:
        return TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: AppBorders.roundedSm),
        );
    }
  }
}

enum ButtonSize {
  small(32.0, 16.0),
  medium(40.0, 20.0),
  large(48.0, 24.0);

  final double height;
  final double iconSize;

  const ButtonSize(this.height, this.iconSize);

  TextStyle get textStyle {
    switch (this) {
      case ButtonSize.small:
        return AppTypography.labelLarge;
      case ButtonSize.medium:
        return AppTypography.bodyLarge;
      case ButtonSize.large:
        return AppTypography.titleLarge;
    }
  }
} 