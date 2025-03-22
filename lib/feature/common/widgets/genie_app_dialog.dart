import 'package:flutter/material.dart';

class GenieAppDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onOkPressed;

  const GenieAppDialog({
    super.key,
    required this.title,
    required this.message,
    this.onOkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onOkPressed != null) onOkPressed!();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
