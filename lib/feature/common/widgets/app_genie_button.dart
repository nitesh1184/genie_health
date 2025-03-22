import 'package:flutter/material.dart';

class AppGenieButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final double height;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final double fontSize;

  const AppGenieButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.height = 40,
    required this.backgroundColor,
    this.borderColor = Colors.black,
    this.textColor = Colors.white,
    this.borderRadius = 2.0,
    this.fontSize = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width* 0.70,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}