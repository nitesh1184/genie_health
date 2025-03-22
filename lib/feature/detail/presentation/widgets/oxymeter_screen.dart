import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../core/Depenency_injections/app_injector.dart';
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
        appBar: AppBar(title: Text('Oximeter Screening',style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.blue[700],
        ),
        body: BlocBuilder<PatientDetailCubit, PatientDataState>(
          builder: (context, state) {
            if (state is PatientDataLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PatientDataFailure) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is PatientDataSuccess) {
              final user = state.data;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Name:',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(user.name, style: TextStyle(fontSize: 24)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Uhid:',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(user.uhid, style: TextStyle(fontSize: 24)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Labour ID:',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(user.labourId, style: TextStyle(fontSize: 24)),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 120,
                      child: SfBarcodeGenerator(
                        value: state.data.labourId,
                        symbology: Code128(),
                        showValue: true,
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
}
