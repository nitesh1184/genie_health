import 'package:flutter/material.dart';

class GenieAppProgressDialog extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final double fontSize;

  const GenieAppProgressDialog({
    super.key,
    required this.text,
    this.borderColor = Colors.white,
    this.textColor = Colors.white,
    this.borderRadius = 2.0,
    this.fontSize = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF207D8B), // background teal tone
        body: SafeArea(
        child: Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
        ),
    );
  }
}
