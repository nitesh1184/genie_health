import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/Depenency_injections/app_injector.dart';
import '../../../../common/user/cubit/user_cubit.dart';
import '../../../../detail/domain/entity/patient_model.dart';
import '../../../../detail/presentation/cubit/patient_detail_cubit.dart';
import '../../../../detail/presentation/cubit/patient_detail_state.dart';
import '../../../../detail/presentation/widgets/patient_info_card.dart';
import '../../../../detail/presentation/widgets/top_bar.dart';
import '../../../common/domain/entities/lab_report_parameter_entity.dart';
import '../cubit/optometry_cubit.dart';
import '../cubit/optometry_state.dart';

class OptometryScreen extends StatefulWidget {
  const OptometryScreen({super.key});

  @override
  State<OptometryScreen> createState() => _OptometryScreenState();
}

class _OptometryScreenState extends State<OptometryScreen> {
  final TextEditingController symptomsController = TextEditingController();
  final TextEditingController occularController = TextEditingController();
  final TextEditingController externalEyeController = TextEditingController();
  final TextEditingController refractionController = TextEditingController();
  final TextEditingController acuityReController = TextEditingController();
  final TextEditingController acuityLeController = TextEditingController();
  late LabReportEntity optometryEntity;
  late PatientDetailCubit patientCubit;
  Patient? patient;

  @override
  void initState() {
    super.initState();
    patientCubit = sl<PatientDetailCubit>();
  }

  @override
  void dispose() {
    symptomsController.dispose();
    occularController.dispose();
    externalEyeController.dispose();
    refractionController.dispose();
    acuityReController.dispose();
    acuityLeController.dispose();
    super.dispose();
  }

  void populateFields(LabReportEntity report) {
    for (var param in report.parameters) {

      switch (param.name) {
        case 'Symptom':
          symptomsController.text = param.value;
          break;
        case 'Occular Finding':
          occularController.text = param.value;
          break;
        case 'External Eye Exam Finding':
          externalEyeController.text = param.value;
          break;
        case 'Refraction':
          refractionController.text = param.value;
          break;
        case 'Visual Acuity - LE':
          acuityLeController.text = param.value;
          break;
        case 'Visual Acuity - RE':
          acuityReController.text = param.value;
          break;



      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final userName = user!.name;
    return MultiBlocProvider(
      providers: [
        BlocProvider<OptometryCubit>(create: (_) => sl<OptometryCubit >()..getOptometryData()),
        BlocProvider<PatientDetailCubit>(
          create: (_) => patientCubit..getDetails(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: TopBar(
              title: userName,
              onBack: () {
                context.pop();
              },
            ),
          ),
          body: BlocConsumer<OptometryCubit , OptometryState>(
            listener: (context, state) {
              if (state is OptometryLoadSuccess) {
                optometryEntity = state.optometryData;
                populateFields(optometryEntity);
              } else if (state is OptometrySaveSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Optometry Saved Successfully')),
                );
                context.pop();
              } else if (state is OptometrySaveFailed) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is OptometryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OptometryLoadSuccess || state is OptometrySaving) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<PatientDetailCubit, PatientDataState>(
                        builder: (context, patientState) {
                          final patientCubit =
                          context.read<PatientDetailCubit>();
                          if(patientState is PatientDataSuccess && patient==null) {
                            patient = patientState.data;
                          }
                          return PatientInfoCard(
                            isExpanded: patientState is PatientDataSuccess ? patientState.isExpanded : false,
                            onToggleExpand: () => patientCubit.toggleExpandCollapse(),
                          );
                        },
                      ), // 🧩 Reusable card
                      const SizedBox(height: 16),
                      const Text(
                        'Optometry',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Symptoms',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 60,
                        child: _buildTextField('', symptomsController),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Occular findings',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 60,
                        child: _buildTextField('', occularController),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'External Eye Examination',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 60,
                        child: _buildTextField('', externalEyeController),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Refraction',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 60,
                        child: _buildTextField('', refractionController),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  'Visual Acuity - RE',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: _buildTextField('', acuityReController),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  'Visual Acuity - LE',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: _buildTextField('', acuityLeController),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => context.pop(),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Implement device view
                              },
                              child: const Text('Device View'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final requestBody = _prepareRequest();
                            context.read<OptometryCubit>().saveParameter(requestBody);
                          },
                          child: const Text('Save Reading'),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Map<String, dynamic> _prepareRequest() {
    return {
      "name": "OPTOMETRY",
      "department": "Basic Health Checkup Report",
      "bar_code": patient!.barcode,
      "parameters": [
        _parameter("Symptom", symptomsController.text, ""),
        _parameter("Occular Finding", occularController.text, ""),
        _parameter("External Eye Exam Finding", externalEyeController.text, ""),
        _parameter("Refraction", refractionController.text, ""),
        _parameter("Visual Acuity - LE", acuityLeController.text, ""),
        _parameter("Visual Acuity - RE", acuityReController.text, ""),
      ],
    };
  }

  Map<String, dynamic> _parameter(String name, String value, String unit) {
    return {
      "name": name,
      "uhid": patient!.uhid,
      "bar_code": patient!.barcode,
      "parameter_group_name": "OPTOMETRY",
      "machine_code": "",
      "value": value,
      "unit": unit,
      "comments": "",
    };
  }

}
