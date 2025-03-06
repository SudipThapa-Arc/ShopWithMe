import 'package:flutter/material.dart';
import 'package:shopwithme/common_widgets/custom_error_widget.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(Object error, StackTrace? stackTrace)? errorBuilder;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;
  StackTrace? _stackTrace;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder!(_error!, _stackTrace);
      }
      return CustomErrorWidget(
        title: 'Something went wrong',
        message: 'An unexpected error occurred. Please try again later.',
        onRetry: () {
          setState(() {
            _error = null;
            _stackTrace = null;
          });
        },
      );
    }

    ErrorWidget.builder = (FlutterErrorDetails details) {
      return CustomErrorWidget(
        title: 'Error',
        message: details.exception.toString(),
      );
    };

    return widget.child;
  }
}