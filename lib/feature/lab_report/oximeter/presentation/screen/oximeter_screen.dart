import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heath_genie/feature/lab_report/common/domain/entities/lab_report_parameter_entity.dart';
import '../../../../../core/Depenency_injections/app_injector.dart';
import '../../../../common/user/cubit/user_cubit.dart';
import '../../../../detail/presentation/cubit/patient_detail_cubit.dart';
import '../../../../detail/presentation/cubit/patient_detail_state.dart';
import '../../../../detail/presentation/widgets/patient_info_card.dart';
import '../../../../detail/presentation/widgets/top_bar.dart';
import '../cubit/oximeter_cubit.dart';
import '../cubit/oximeter_state.dart';

// your existing reusable widget

class OximeterScreen extends StatefulWidget {
  const OximeterScreen({super.key});

  @override
  State<OximeterScreen> createState() => _OximeterScreenState();
}

class _OximeterScreenState extends State<OximeterScreen> {
  final TextEditingController oxygenController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  late LabReportEntity oximeterEntity;
  late PatientDetailCubit patientCubit;

  @override
  void initState() {
    super.initState();
    patientCubit = sl<PatientDetailCubit>();
  }

  @override
  void dispose() {
    oxygenController.dispose();
    heartRateController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void populateFields(LabReportEntity report) {
    for (var param in report.parameters) {

      switch (param.name) {
        case 'SPO2':
          oxygenController.text = param.value;
          break;
        case 'Heart Rate':
          heartRateController.text = param.value;

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
        BlocProvider<OximeterCubit>(create: (_) => sl<OximeterCubit>()..getOximeterData()),
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
          body: BlocConsumer<OximeterCubit , OximeterState>(
            listener: (context, state) {
              if (state is OximeterLoadSuccess) {
                oximeterEntity = state.oximeterData;
                populateFields(oximeterEntity);
              } else if (state is OximeterSaveSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('BMI Data Saved Successfully')),
                );
                context.pop();


              } else if (state is OximeterSaveFailed) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is OximeterLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OximeterLoadSuccess || state is OximeterSaving) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<PatientDetailCubit, PatientDataState>(
                        builder: (context, patientState) {
                          final patientCubit =
                          context.read<PatientDetailCubit>();
                          return PatientInfoCard(
                            isExpanded: patientCubit.isExpanded,
                            onToggleExpand: patientCubit.toggleExpandCollapse,
                          );
                        },
                      ), // 🧩 Reusable card
                      const SizedBox(height: 16),
                      const Text(
                        'Oximeter Screening',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'SpO2 Level (%)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: _buildTextField(
                          '', oxygenController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Heart Rate (BPM)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: _buildTextField(
                          '', heartRateController,
                        ),
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
                            context.read<OximeterCubit>().saveParameter(requestBody);
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
      "name": "OXIMETER",
      "department": "Basic Health Checkup Report",
      "bar_code": "243671063",
      "parameters": [
        _parameter("SPO2", oxygenController.text, "%"),
        _parameter("Heart Rate", heartRateController.text, "BPM"),
        _parameter("Notes", notesController.text, ""),
      ],
    };
  }

  Map<String, dynamic> _parameter(String name, String value, String unit) {
    return {
      "name": name,
      "uhid": "KA-256496983",
      "bar_code": "243671063",
      "parameter_group_name": "OXIMETER",
      "machine_code": "",
      "value": value,
      "unit": unit,
      "comments": "",
    };
  }

}
