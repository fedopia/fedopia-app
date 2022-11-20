import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final String error;
  final VoidCallback? onRetry;
  const AppError(this.error, {super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(error),
      ],
    );
  }
}
