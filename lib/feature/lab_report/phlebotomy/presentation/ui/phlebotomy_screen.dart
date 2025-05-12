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
import '../cubit/phlebotomy_cubit.dart';
import '../cubit/phlebotomy_state.dart';

class PhlebotomyScreen extends StatefulWidget {
  const PhlebotomyScreen({super.key});

  @override
  State<PhlebotomyScreen> createState() => _PhlebotomyScreenState();
}

class _PhlebotomyScreenState extends State<PhlebotomyScreen> {
  final TextEditingController linkController = TextEditingController();
  late LabReportEntity phlebotomyEntity;
  late PatientDetailCubit patientCubit;
  late PhlebotomyCubit phlebotomyCubit;
  Patient? patient;
  bool _checked=false;

  @override
  void initState() {
    super.initState();
    patientCubit = sl<PatientDetailCubit>();
    phlebotomyCubit = sl<PhlebotomyCubit>();
  }

  @override
  void dispose() {
    linkController.dispose();
    super.dispose();
  }

  void populateFields(LabReportEntity report) {
    for (var param in report.parameters) {
      if (param.name == 'Blood Sample Successfully Collected') {
        _checked = param.value.toLowerCase() == 'true';
      }
      if (param.name == 'Collection Site') {
        linkController.text = param.value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final userName = user!.name;
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhlebotomyCubit>(
          create: (_) => sl<PhlebotomyCubit>()..getPhlebotomyData(),
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
          body: BlocConsumer<PhlebotomyCubit, PhlebotomyState>(
            listener: (context, state) {
              if (state is PhlebotomyLoadSuccess) {
                phlebotomyEntity = state.phlebotomyData;
                populateFields(phlebotomyEntity);
              } else if (state is PhlebotomySaveSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Phlebotomy Data Saved Successfully'),
                  ),
                );
                context.pop();
              } else if (state is PhlebotomySaveFailed) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
              else if (state is CheckBoxValueChanged) {
                setState(() {
                  _checked = state.isChecked;
                });
              }
            },
            builder: (context, state) {
              if (state is PhlebotomyLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if ((state is PhlebotomyLoadSuccess ||
                  state is PhlebotomySaving) || state is CheckBoxValueChanged ) {
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
                        'Phlebotomy',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF207D8B),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            activeColor: Color(0xFF207D8B),
                            value: _checked,
                            onChanged: (value) {
                              context.read<PhlebotomyCubit>().toggleCheckBox(value!);
                            },
                          ),
                          SizedBox(width: 12),
                          const Text("Blood sample successfully collected"),
                        ],
                      ),
                      const Text(
                        'Collection Site',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: _buildTextField('', linkController),
                      ),

                      const SizedBox(width: 24),
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
                              onPressed: () {
                                final requestBody = _prepareRequest();
                                context.read<PhlebotomyCubit>().saveParameter(
                                  requestBody,
                                );
                              },
                              icon: const Icon(
                                Icons.save_outlined,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
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
      "name": "PHLEBOTOMY",
      "department": "Basic Health Checkup Report",
      "bar_code": patient!.barcode,
      "parameters": [
        _parameter(
          "Blood Sample Successfully Collected",
          _checked ? 'true' : 'false',
          "",
        ),
      ],
    };
  }

  Map<String, dynamic> _parameter(String name, String value, String unit) {
    return {
      "name": name,
      "uhid": patient!.uhid,
      "bar_code": patient!.barcode,
      "parameter_group_name": "PHLEBOTOMY",
      "machine_code": "",
      "value": value,
      "unit": unit,
      "comments": "",
    };
  }
}
