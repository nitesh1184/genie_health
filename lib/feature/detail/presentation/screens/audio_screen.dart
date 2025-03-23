import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/common/widgets/app_genie_button.dart';
import 'package:heath_genie/feature/common/widgets/genie_app_dialog.dart';
import 'package:heath_genie/feature/detail/presentation/cubit/patient_detail_cubit.dart';
import 'package:heath_genie/feature/detail/presentation/cubit/patient_detail_state.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../core/Depenency_injections/app_injector.dart';
import '../../../common/user/cubit/user_cubit.dart';
import '../../../common/widgets/app_scafold.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

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
                        value: state.data.labourId.string,
                        symbology: Code128(),
                        showValue: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AppGenieButton(
                      onPressed: () {
                        showDialogBox(context);
                      },
                      backgroundColor: Colors.blue,
                      buttonText: '500HZ',
                    ),
                    const SizedBox(height: 20),
                    AppGenieButton(
                      onPressed: () {
                        showDialogBox(context);
                      },
                      buttonText: '1000HZ',
                      backgroundColor: Colors.blue,
                    ),
                    const SizedBox(height: 20),
                    AppGenieButton(
                      onPressed: () {
                        showDialogBox(context);
                      },
                      buttonText: '2000HZ',
                      backgroundColor: Colors.blue,
                    ),
                    const SizedBox(height: 20),
                    AppGenieButton(
                      onPressed: () {
                        showDialogBox(context);
                      },
                      buttonText: '4000HZ',
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

  void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return GenieAppDialog(
          title: "Wait...",
          message: "This feature is coming soon",
        );
      },
    );
  }
}
