import 'package:flutter/material.dart';

class L10n {
  L10n._(); //coverage:ignore-line

  static final all = [
    const Locale('en'),
    const Locale('hi'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'hi':
        return 'Hindi';
      case 'en':
        return 'English';
      default:
        return 'English';
    }
  }
}