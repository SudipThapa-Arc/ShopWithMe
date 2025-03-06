import 'package:flutter/material.dart';
import 'package:shopwithme/design_system/colors.dart';

class Elevation {
  static List<BoxShadow> get none => [];

  static List<BoxShadow> get low => [
    BoxShadow(
      color: AppColors.textPrimary.withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get medium => [
    BoxShadow(
      color: AppColors.textPrimary.withOpacity(0.08),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get high => [
    BoxShadow(
      color: AppColors.textPrimary.withOpacity(0.12),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
} 