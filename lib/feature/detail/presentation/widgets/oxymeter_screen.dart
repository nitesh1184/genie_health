import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../core/Depenency_injections/app_injector.dart';
import '../../../common/widgets/genie_app_dialog.dart';
import '../cubit/patient_detail_cubit.dart';
import '../cubit/patient_detail_state.dart';

class OxiMeterScreen extends StatefulWidget {
  const OxiMeterScreen({super.key});

  @override
  OxiMeterScreenState createState() => OxiMeterScreenState();
}

class OxiMeterScreenState extends State<OxiMeterScreen> {
  TextEditingController pulseController = TextEditingController();
  TextEditingController oxygenSatController = TextEditingController();
  Color pulseColor = Colors.white;
  Color oxygenSatColor = Colors.white;

  void updateColors() {
    setState(() {
      int? pulse = int.tryParse(pulseController.text);
      int? oxygenSat = int.tryParse(oxygenSatController.text);

      pulseColor =
          (pulse != null && (pulse < 60 || pulse > 90))
              ? Colors.red
              : Colors.lightGreen;
      oxygenSatColor =
          (oxygenSat != null && oxygenSat < 90)
              ? Colors.red
              : (oxygenSat != null && oxygenSat > 100)
              ? Colors.lightBlue
              : Colors.lightGreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PatientDetailCubit>()..getDetails(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Oximeter Screening',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue[700],
        ),
        body: BlocBuilder<PatientDetailCubit, PatientDataState>(
          builder: (context, state) {
            if (state is PatientDataLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PatientDataFailure) {
              showDialogBox(context, 'Something went wrong', state.message);
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is PatientDataSuccess) {
              final patient = state.data;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Name:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          patient.name.string,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Uhid:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          patient.uhid.string,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Labour ID:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          patient.labourId.string,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: SfBarcodeGenerator(
                        value: patient.labourId.string,
                        symbology: Code128(),
                        showValue: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: pulseController,
                      decoration: InputDecoration(
                        labelText: 'Pulse',
                        fillColor: pulseColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (_) => updateColors(),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: oxygenSatController,
                      decoration: InputDecoration(
                        labelText: 'Oxygen Sat',
                        fillColor: oxygenSatColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (_) => updateColors(),
                    ),
                  ],
                ),
              );
            }
            return Center(child: Text('No Data Available'));
          },
        ),
      ),
    );
  }

  void showDialogBox(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return GenieAppDialog(title: title, message: message);
      },
    );
  }
}
