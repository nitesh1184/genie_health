import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/common/widgets/app_genie_button.dart';
import 'package:heath_genie/feature/detail/presentation/cubit/patient_detail_cubit.dart';
import 'package:heath_genie/feature/detail/presentation/cubit/patient_detail_state.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../core/Depenency_injections/app_injector.dart';
import '../../../common/user/cubit/user_cubit.dart';
import '../../../common/widgets/genie_app_bar.dart';
import '../../../common/widgets/genie_app_dialog.dart';

class OptoDetailScreen extends StatelessWidget {
  const OptoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final userName = user!.name;
    return BlocProvider(
      create: (context) => sl<PatientDetailCubit>()..getDetails(),
      child: Scaffold(
        appBar: GenieAppBar(username: userName),
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
                    AppGenieButton(
                      onPressed: () {
                        showDialogBox(context);
                      },
                      backgroundColor: Colors.blue,
                      buttonText: 'RE',
                    ),
                    const SizedBox(height: 40),
                    AppGenieButton(
                      onPressed: () {
                        showDialogBox(context);
                      },
                      buttonText: 'LE',
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
