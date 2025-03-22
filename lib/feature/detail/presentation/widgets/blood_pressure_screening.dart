import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../core/Depenency_injections/app_injector.dart';
import '../cubit/patient_detail_cubit.dart';
import '../cubit/patient_detail_state.dart';

class BloodPressureScreen extends StatefulWidget {
  const BloodPressureScreen({super.key});

  @override
  BloodPressureScreenState createState() => BloodPressureScreenState();
}

class BloodPressureScreenState extends State<BloodPressureScreen> {
  TextEditingController systolicController = TextEditingController();
  TextEditingController diastolicController = TextEditingController();
  Color systolicColor = Colors.white;
  Color diastolicColor = Colors.white;

  @override
  void dispose() {
    systolicController.dispose();
    diastolicController.dispose();
    super.dispose();
  }

  void updateColors() {
    setState(() {
      int? systolic = int.tryParse(systolicController.text);
      int? diastolic = int.tryParse(diastolicController.text);

      if (systolic != null) {
        if (systolic < 90 || systolic > 140) {
          systolicColor = Colors.red;
        } else if (systolic >= 90 && systolic <= 130) {
          systolicColor = Colors.lightGreen;
        } else {
          systolicColor = Colors.redAccent;
        }
      }

      if (diastolic != null) {
        if (diastolic < 60 || diastolic > 100) {
          diastolicColor = Colors.red;
        } else if (diastolic >= 60 && diastolic <= 90) {
          diastolicColor = Colors.lightGreen;
        } else {
          diastolicColor = Colors.redAccent;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PatientDetailCubit>()..getDetails(),
      child: Scaffold(
        appBar: AppBar(title: Text('Blood Pressure Screening',style: TextStyle(color: Colors.white),),
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
                      controller: systolicController,
                      decoration: InputDecoration(
                        labelText: 'Systolic',
                        fillColor: systolicColor,
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
                    SizedBox(height:20),
                    TextField(
                      controller: diastolicController,
                      decoration: InputDecoration(
                        labelText: 'Diastolic',
                        fillColor: diastolicColor,
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
