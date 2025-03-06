import 'package:flutter/material.dart';
import 'package:shopwithme/constants/consts.dart';

class FormErrorWidget extends StatelessWidget {
  final String message;
  final bool showIcon;

  const FormErrorWidget({
    super.key,
    required this.message,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showIcon) ...[
          Icon(
            Icons.error_outline,
            size: 16,
            color: redColor,
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              color: redColor,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
} 