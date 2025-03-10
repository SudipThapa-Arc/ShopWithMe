import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/typography.dart';

class ErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onRetry;
  final String? retryText;

  const ErrorWidget({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.error_outline,
    this.onRetry,
    this.retryText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Spacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppColors.error,
            ),
            SizedBox(height: Spacing.md),
            Text(
              title,
              style: AppTypography.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Spacing.sm),
            Text(
              message,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: Spacing.lg),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh),
                label: Text(retryText ?? 'Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.lg,
                    vertical: Spacing.md,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Factory constructors for common error types
  factory ErrorWidget.network({
    VoidCallback? onRetry,
    String? retryText,
  }) {
    return ErrorWidget(
      title: 'Network Error',
      message: 'Please check your internet connection and try again.',
      icon: Icons.wifi_off,
      onRetry: onRetry,
      retryText: retryText,
    );
  }

  factory ErrorWidget.empty({
    String title = 'No Results Found',
    String message = 'We couldn\'t find any items matching your criteria.',
    IconData icon = Icons.search_off,
    VoidCallback? onRetry,
    String? retryText,
  }) {
    return ErrorWidget(
      title: title,
      message: message,
      icon: icon,
      onRetry: onRetry,
      retryText: retryText,
    );
  }

  factory ErrorWidget.server({
    VoidCallback? onRetry,
    String? retryText,
  }) {
    return ErrorWidget(
      title: 'Server Error',
      message: 'Something went wrong on our end. Please try again later.',
      icon: Icons.cloud_off,
      onRetry: onRetry,
      retryText: retryText,
    );
  }
}

class FormErrorWidget extends StatelessWidget {
  final String message;

  const FormErrorWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return VStack([
      HStack([
        Icon(
          Icons.error_outline,
          color: AppColors.error,
          size: 16,
        ),
        8.widthBox,
        message.text.color(AppColors.error).make(),
      ]),
    ]).p8().box.border(color: AppColors.error).roundedSM.make();
  }
}

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionText;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        Icon(
          icon,
          size: 64,
          color: AppColors.neutral,
        ).centered(),
        Spacing.lg.heightBox,
        title.text.xl2.bold.color(AppColors.textPrimary).makeCentered(),
        Spacing.sm.heightBox,
        message.text.center.color(AppColors.textSecondary).makeCentered(),
        if (onAction != null) ...[
          Spacing.lg.heightBox,
          ElevatedButton(
            onPressed: onAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.lg,
                vertical: Spacing.md,
              ),
            ),
            child: actionText!.text.make(),
          ).centered(),
        ],
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).p24();
  }

  // Factory constructors for common empty states
  factory EmptyStateWidget.cart({
    VoidCallback? onAction,
  }) {
    return EmptyStateWidget(
      title: 'Your Cart is Empty',
      message: 'Add items to your cart to start shopping.',
      icon: Icons.shopping_cart_outlined,
      onAction: onAction,
      actionText: 'Browse Products',
    );
  }

  factory EmptyStateWidget.wishlist({
    VoidCallback? onAction,
  }) {
    return EmptyStateWidget(
      title: 'Your Wishlist is Empty',
      message: 'Save items to your wishlist for later.',
      icon: Icons.favorite_border,
      onAction: onAction,
      actionText: 'Browse Products',
    );
  }

  factory EmptyStateWidget.search({
    VoidCallback? onAction,
  }) {
    return EmptyStateWidget(
      title: 'No Results Found',
      message: 'Try different keywords or browse categories.',
      icon: Icons.search_off,
      onAction: onAction,
      actionText: 'Browse Categories',
    );
  }
} 