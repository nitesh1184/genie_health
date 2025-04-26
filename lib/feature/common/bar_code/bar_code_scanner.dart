import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerScreen extends StatelessWidget {
  const BarcodeScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Barcode')),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) {
          final Barcode? barcode = capture.barcodes.firstOrNull;
          final String? code = barcode?.rawValue;
          if (code != null) {
            context.pop(code);
          }
        },
      ),
    );
  }
}
