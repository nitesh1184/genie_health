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
import '../cubit/spirometer_cubit.dart';
import '../cubit/spirometer_state.dart'; // your existing reusable widget

class SpirometerScreen extends StatefulWidget {
  const SpirometerScreen({super.key});

  @override
  State<SpirometerScreen> createState() => _SpirometerScreenState();
}

class _SpirometerScreenState extends State<SpirometerScreen> {
  final TextEditingController fefController = TextEditingController();
  final TextEditingController pefController = TextEditingController();
  final TextEditingController fev1Controller = TextEditingController();
  final TextEditingController fev6Controller = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  late LabReportEntity spirometerEntity;
  late PatientDetailCubit patientCubit;
  Patient? patient;

  @override
  void initState() {
    super.initState();
    patientCubit = sl<PatientDetailCubit>();
  }

  @override
  void dispose() {
    fefController.dispose();
    pefController.dispose();
    fev1Controller.dispose();
    fev6Controller.dispose();
    notesController.dispose();
    super.dispose();
  }

  void populateFields(LabReportEntity report) {
    for (var param in report.parameters) {
      switch (param.name) {
        case 'FEF':
          fefController.text = param.value;
          break;
        case 'PEF':
          pefController.text = param.value;
          break;
        case 'FEV1':
          fev1Controller.text = param.value;
          notesController.text = param.comments;
          break;
        case 'FEV6':
          fev6Controller.text = param.value;
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
        BlocProvider<SpirometerCubit>(
          create: (_) => sl<SpirometerCubit>()..getSpirometerData(),
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
          body: BlocConsumer<SpirometerCubit, SpirometerState>(
            listener: (context, state) {
              if (state is SpirometerLoadSuccess) {
                spirometerEntity = state.spirometerData;
                populateFields(spirometerEntity);
              } else if (state is SpirometerSaveSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data Saved Successfully')),
                );
                context.pop();
              } else if (state is SpirometerSaveFailed) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is SpirometerLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SpirometerLoadSuccess ||
                  state is SpirometerSaving) {
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
                        'Spirometer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField('FEF', fefController),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField('PEF', pefController),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField('FEV1', fev1Controller),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField('FEV6', fev6Controller),
                          ),
                        ],
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
                            context.read<SpirometerCubit>().saveParameter(
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
      "name": "SPIROMETER",
      "department": "Basic Health Checkup Report",
      "bar_code": patient!.barcode,
      "parameters": [
        _parameter("FEF", fefController.text, ""),
        _parameter("PEF", pefController.text, ""),
        _parameter("FEV1", fev1Controller.text, ""),
        _parameter("FEV6", fev6Controller.text, ""),
      ],
    };
  }

  Map<String, dynamic> _parameter(String name, String value, String unit) {
    return {
      "name": name,
      "uhid": patient!.uhid,
      "bar_code": patient!.barcode,
      "parameter_group_name": "SPIROMETER",
      "machine_code": "",
      "value": value,
      "unit": unit,
      "comments": notesController.text,
    };
  }
}
