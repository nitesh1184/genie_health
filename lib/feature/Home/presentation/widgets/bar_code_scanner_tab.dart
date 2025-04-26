import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heath_genie/feature/Home/presentation/widgets/prevously_scanned_patient_widget.dart';

import '../../../common/bar_code/bar_code_cubit.dart';

class ScanBarcodeTab extends StatelessWidget {
  const ScanBarcodeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BarcodeCubit, String?>(
        listener: (context, barcode) {
      if(barcode!=null || barcode!.isNotEmpty){
        context.push('/patientDetail');
      }
    },
    child:Column(
      children: [
        GestureDetector(
          onTap: () {
            _scanBarcode(context);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.qr_code_scanner, size: 80),
          ),
        ),
        ElevatedButton(
          onPressed: () => _scanBarcode(context),
          child: const Text("Scan Barcode"),
        ),
        const Divider(height: 32),
        const Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 8),
          child: Text("Previous Screened Patients", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const Expanded(child: ScannedPatientListWidget()),
      ],
    )
    );
  }
  void _scanBarcode(BuildContext context) async {
    final push = context.push;
    final barcodeCubit = context.read<BarcodeCubit>();

    final String? scannedCode = await push('/scanner');

    if (scannedCode != null) {
      barcodeCubit.setBarcode(scannedCode);
    }
  }
}