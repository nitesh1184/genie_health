import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heath_genie/feature/common/widgets/app_genie_button.dart';
import 'package:heath_genie/feature/detail/presentation/cubit/patient_detail_cubit.dart';
import 'package:heath_genie/feature/detail/presentation/cubit/patient_detail_state.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../core/Depenency_injections/app_injector.dart';
import '../../../common/user/cubit/user_cubit.dart';
import '../../../common/widgets/app_scafold.dart';
import '../../../common/widgets/genie_app_dialog.dart';

class DoctorDetailScreen extends StatelessWidget {
  const DoctorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final userName = user!.name;
    return BlocProvider(
      create: (context) => sl<PatientDetailCubit>()..getDetails(),
      child: AppScaffold(
        username: userName,
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
                    AppGenieButton(
                      onPressed: () {
                        context.push('/bpScreening');
                      },
                      backgroundColor: Colors.blue,
                      buttonText: 'Blood Pressure Screening',
                    ),
                    const SizedBox(height: 20),
                    AppGenieButton(
                      onPressed: () {
                        context.push('/BmiScreen');
                      },
                      buttonText: 'BMI',
                      backgroundColor: Colors.blue,
                    ),
                    const SizedBox(height: 20),
                    AppGenieButton(
                      onPressed: () {
                        context.push('/oximeter');
                      },
                      buttonText: 'Oximeter Screening',
                      backgroundColor: Colors.blue,
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
