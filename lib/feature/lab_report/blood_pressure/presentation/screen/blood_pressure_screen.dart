import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heath_genie/feature/lab_report/common/domain/entities/lab_report_parameter_entity.dart';
import '../../../../../core/Depenency_injections/app_injector.dart';
import '../../../../common/user/cubit/user_cubit.dart';
import '../../../../detail/domain/entity/patient_model.dart';
import '../../../../detail/presentation/cubit/patient_detail_cubit.dart';
import '../../../../detail/presentation/cubit/patient_detail_state.dart';
import '../../../../detail/presentation/widgets/patient_info_card.dart';
import '../../../../detail/presentation/widgets/top_bar.dart';
import '../cubit/blood_pressure_cubit.dart';
import '../cubit/blood_pressure_state.dart';
// your existing reusable widget

class BloodPressureScreen extends StatefulWidget {
  const BloodPressureScreen({super.key});

  @override
  State<BloodPressureScreen> createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  final TextEditingController systolicController = TextEditingController();
  final TextEditingController diastolicController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  late LabReportEntity bloodPressureEntity;
  late PatientDetailCubit patientCubit;
  Patient? patient;

  @override
  void initState() {
    super.initState();
    patientCubit = sl<PatientDetailCubit>();
  }

  @override
  void dispose() {
    systolicController.dispose();
    diastolicController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void populateFields(LabReportEntity report) {
    for (var param in report.parameters) {
      switch (param.name) {
        case 'Systolic':
          systolicController.text = param.value;
          break;
        case 'Diastolic':
          diastolicController.text = param.value;

          break;
        case 'Notes':
          notesController.text = param.value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final userName = user!.name;
    return MultiBlocProvider(
      providers: [
        BlocProvider<BloodPressureCubit>(
          create: (_) => sl<BloodPressureCubit>()..getBloodPressureData(),
        ),
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
          body: BlocConsumer<BloodPressureCubit, BloodPressureState>(
            listener: (context, state) {
              if (state is BloodPressureLoadSuccess) {
                bloodPressureEntity = state.bloodPressureData;
                populateFields(bloodPressureEntity);
              } else if (state is BloodPressureSaveSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data Saved Successfully')),
                );
                context.pop();
              } else if (state is BloodPressureSaveFailed) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is BloodPressureLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BloodPressureLoadSuccess ||
                  state is BloodPressureSaving) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<PatientDetailCubit, PatientDataState>(
                        builder: (context, patientState) {
                          final patientCubit =
                              context.read<PatientDetailCubit>();
                          if (patientState is PatientDataSuccess &&
                              patient == null) {
                            patient = patientState.data;
                          }
                          return PatientInfoCard(
                            isExpanded:
                                patientState is PatientDataSuccess
                                    ? patientState.isExpanded
                                    : false,
                            onToggleExpand:
                                () => patientCubit.toggleExpandCollapse(),
                          );
                        },
                      ), // 🧩 Reusable card
                      const SizedBox(height: 16),
                      const Text(
                        'Blood Pressure Screening',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF207D8B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Systolic Pressure (mmHg)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: _buildTextField('', systolicController),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'diastolic Pressure (mmHg)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: _buildTextField('', diastolicController),
                      ),

                      const SizedBox(height: 16),
                      _buildMultilineTextField(
                        'Notes (Optional)',
                        notesController,
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
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF005D57),
                              ),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.device_unknown_rounded,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Device View',
                                style: TextStyle(color: Colors.white),
                              ),
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
                            context.read<BloodPressureCubit>().saveParameter(
                              requestBody,
                            );
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

  Widget _buildMultilineTextField(
    String label,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Map<String, dynamic> _prepareRequest() {
    return {
      "name": "BLOOD PRESSURE",
      "department": "Basic Health Checkup Report",
      "bar_code": patient!.barcode,
      "parameters": [
        _parameter("Diastolic", diastolicController.text, "mmHg"),
        _parameter("Systolic", systolicController.text, "mmHg"),
      ],
    };
  }

  Map<String, dynamic> _parameter(String name, String value, String unit) {
    return {
      "name": name,
      "uhid": patient!.uhid,
      "bar_code": patient!.barcode,
      "parameter_group_name": "BLOOD PRESSURE",
      "machine_code": "",
      "value": value,
      "unit": unit,
      "comments": notesController.text,
    };
  }
}
