import 'package:flutter/material.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/borders.dart';
import 'package:shopwithme/design_system/spacing.dart';

class AppInput extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? error;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool isLoading;

  const AppInput({
    super.key,
    this.label,
    this.hint,
    this.error,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTypography.labelLarge),
          SizedBox(height: Spacing.xs),
        ],
        TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: AppTypography.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            errorText: error,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: _buildSuffixIcon(),
            border: OutlineInputBorder(
              borderRadius: AppBorders.roundedSm,
              borderSide: const BorderSide(color: AppColors.neutral),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppBorders.roundedSm,
              borderSide: const BorderSide(color: AppColors.neutral),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppBorders.roundedSm,
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppBorders.roundedSm,
              borderSide: const BorderSide(color: AppColors.error),
            ),
            contentPadding: const EdgeInsets.all(Spacing.md),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: Padding(
          padding: EdgeInsets.all(Spacing.sm),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    if (suffixIcon != null) {
      return IconButton(
        icon: Icon(suffixIcon),
        onPressed: onSuffixIconPressed,
      );
    }
    return null;
  }
} 