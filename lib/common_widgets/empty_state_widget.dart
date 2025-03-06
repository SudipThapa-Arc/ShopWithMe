import 'package:flutter/material.dart';
import 'package:shopwithme/common_widgets/custom_error_widget.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? title;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.title,
    this.icon = Icons.inbox_outlined,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: title,
      message: message,
      icon: icon,
      onRetry: onAction != null
          ? () {
              onAction!();
            }
          : null,
    );
  }
} 