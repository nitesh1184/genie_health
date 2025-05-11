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
import '../cubit/stethoscope_cubit.dart';
import '../cubit/stethoscope_state.dart';
// your existing reusable widget

class StethoscopeScreen extends StatefulWidget {
  const StethoscopeScreen({super.key});

  @override
  State<StethoscopeScreen> createState() => _StethoscopeScreenState();
}

class _StethoscopeScreenState extends State<StethoscopeScreen> {
  final TextEditingController heartSoundController = TextEditingController();
  final TextEditingController lungSoundsController = TextEditingController();
  final TextEditingController abdomenSoundsController = TextEditingController();
  late LabReportEntity stethoscopeEntity;
  late PatientDetailCubit patientCubit;
  late bool isChecked;
  Patient? patient;

  @override
  void initState() {
    super.initState();
    patientCubit = sl<PatientDetailCubit>();
  }

  @override
  void dispose() {
    abdomenSoundsController.dispose();
    lungSoundsController.dispose();
    heartSoundController.dispose();
    super.dispose();
  }

  void populateFields(LabReportEntity report) {
    for (var param in report.parameters) {

      switch (param.name) {
        case 'Heart Sounds':
          heartSoundController.text = param.value;
          break;
        case 'Lung Sounds':
          lungSoundsController.text = param.value;
          break;
        case 'Abdomen Sounds':
          abdomenSoundsController.text = param.value;
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
        BlocProvider<StethoscopeCubit>(create: (_) => sl<StethoscopeCubit>()..getStethoscopeData()),
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
          body: BlocConsumer<StethoscopeCubit , StethoscopeState>(
            listener: (context, state) {
              if (state is StethoscopeLoadSuccess) {
                stethoscopeEntity = state.stethoscopeData;
                isChecked=state.isChecked;
                populateFields(stethoscopeEntity);
              } else if (state is StethoscopeSaveSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data Saved Successfully')),
                );
                context.pop();


              } else if (state is StethoscopeSaveFailed) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is StethoscopeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is StethoscopeLoadSuccess || state is StethoscopeSaving) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<PatientDetailCubit, PatientDataState>(
                        builder: (context, patientState) {
                          final patientCubit =
                          context.read<PatientDetailCubit>();
                          if (patientState is PatientDataSuccess && patient==null) {
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
                        'Stethoscope Assessment',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Heart Sounds',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 60,
                        child: _buildTextField('', heartSoundController),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Lung Sounds',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 60,
                        child: _buildTextField('', lungSoundsController),
                      ),

                      const SizedBox(height: 16),
                      const Text(
                        'Abdomen',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 60,
                        child: _buildTextField('', abdomenSoundsController),
                      ),
                      const SizedBox(height: 16),
                      CheckboxListTile(
                        title: Text("Abnormal findings requiring follow-up"),
                        value: isChecked,
                        onChanged: (value) {
                          context.read<StethoscopeCubit>().toggleCheckbox(value ?? false);
                        },
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
                            context.read<StethoscopeCubit>().saveParameter(requestBody);
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
      "name": "STETHOSCOPE",
      "department": "Basic Health Checkup Report",
      "bar_code": patient!.barcode,
      "parameters": [
        _parameter("Heart Sounds", heartSoundController.text, "%"),
        _parameter("Lung Sounds", lungSoundsController.text, "%"),
        _parameter("Abdomen Sounds", abdomenSoundsController.text, "%"),
        _parameter("Need Follow Up", isChecked?'true':'false', ""),
      ],
    };
  }

  Map<String, dynamic> _parameter(String name, String value, String unit) {
    return {
      "name": name,
      "uhid": patient!.uhid,
      "bar_code": patient!.barcode,
      "parameter_group_name": "STETHOSCOPE",
      "machine_code": "",
      "value": value,
      "unit": unit,
      "comments": "",
    };
  }

}
