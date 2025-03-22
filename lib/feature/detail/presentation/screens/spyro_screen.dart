import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heath_genie/feature/common/widgets/app_genie_button.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../core/Depenency_injections/app_injector.dart';
import '../../../common/user/cubit/user_cubit.dart';
import '../../../common/widgets/genie_app_bar.dart';
import '../cubit/patient_detail_cubit.dart';
import '../cubit/patient_detail_state.dart';

class SpyroScreen extends StatefulWidget {
  const SpyroScreen({super.key});

  @override
  SpyroState createState() => SpyroState();
}

class SpyroState extends State<SpyroScreen> {
  bool fev1Recorded = false;
  bool fev6Recorded = false;

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
            } else if (state is PatientDataSuccess) {
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
                        Text(state.data.name, style: TextStyle(fontSize: 18)),
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
                        Text(state.data.uhid, style: TextStyle(fontSize: 18)),
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
                          state.data.labourId,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 90,
                      child: SfBarcodeGenerator(
                        value: state.data.labourId,
                        symbology: Code128(),
                        showValue: true,
                      ),
                    ),
                    SizedBox(height: 20),

                    AppGenieButton(
                      backgroundColor:
                          fev1Recorded ? Colors.white30 : Colors.blue,
                      onPressed: () async {
                        context.pushNamed(
                          "spyroTest",
                          pathParameters: {'type': 'FEV1'},
                        );
                        setState(() => fev1Recorded = true);
                      },
                      buttonText: "FEV1",
                    ),
                    SizedBox(height: 20),
                    AppGenieButton(
                      backgroundColor:
                          fev6Recorded ? Colors.white30 : Colors.blue,

                      onPressed: () async {
                        context.pushNamed(
                          "spyroTest",
                          pathParameters: {'type': 'FEV1'},
                        );

                        setState(() => fev6Recorded = true);
                      },
                      buttonText: "FEV6",
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AppGenieButton(
                        onPressed: fev1Recorded && fev6Recorded ? () {} : null,
                        buttonText: "Submit",
                        backgroundColor:
                            fev1Recorded && fev6Recorded
                                ? Colors.white30
                                : Colors.blue,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text("Error loading data"));
            }
          },
        ),
      ),
    );
  }
}
