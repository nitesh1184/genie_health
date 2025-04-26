import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heath_genie/feature/Home/presentation/widgets/prevously_scanned_patient_widget.dart';

import '../../../common/bar_code/bar_code_cubit.dart';

class ManualEntryTab extends StatelessWidget {
  const ManualEntryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController barcodeController = TextEditingController();
    return BlocListener<BarcodeCubit, String?>(
        listener: (context, barcode) {
      if(barcode!=null || barcode!.isNotEmpty){
        context.push('/patientDetail');
      }
    },
    child:Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: barcodeController,
            decoration: const InputDecoration(
              labelText: "Enter Patient ID",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final barcodeCubit = context.read<BarcodeCubit>();
            barcodeCubit.setBarcode(barcodeController.text);
          },
          child: const Text("Search Patient"),
        ),
        const Divider(height: 32),
        const Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 8),
          child: Text("Previous Screened Patients", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const Expanded(child: ScannedPatientListWidget()),
      ],
    ),
    );
  }
}