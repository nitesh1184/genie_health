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
import '../cubit/bmi_cubit.dart'; // your existing reusable widget

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController hydrationController = TextEditingController();
  final TextEditingController bodyFatController = TextEditingController();
  final TextEditingController boneMassController = TextEditingController();
  final TextEditingController muscleMassController = TextEditingController();
  final TextEditingController visceralFatController = TextEditingController();
  final TextEditingController metabolicAgeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  late LabReportEntity bmiEntity;
  late PatientDetailCubit patientCubit;
  Patient? patient;

  @override
  void initState() {
    super.initState();
    patientCubit = sl<PatientDetailCubit>();
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    bmiController.dispose();
    hydrationController.dispose();
    bodyFatController.dispose();
    boneMassController.dispose();
    muscleMassController.dispose();
    visceralFatController.dispose();
    metabolicAgeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void populateFields(LabReportEntity report) {
    for (var param in report.parameters) {
      switch (param.name) {
        case 'Weight':
          weightController.text = param.value;
          break;
        case 'Height':
          heightController.text = param.value;
          break;
        case 'BMI':
          bmiController.text = param.value;
          notesController.text = param.comments;
          break;
        case 'Hydration':
          hydrationController.text = param.value;
          break;
        case 'Fat':
          bodyFatController.text = param.value;
          break;
        case 'Bone Mass':
          boneMassController.text = param.value;
          break;
        case 'Muscle':
          muscleMassController.text = param.value;
          break;
        case 'Visceral Fat':
          visceralFatController.text = param.value;
          break;
        case 'Metabolic Age':
          metabolicAgeController.text = param.value;
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
        BlocProvider<BmiCubit>(create: (_) => sl<BmiCubit>()..getBmi()),
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
          body: BlocConsumer<BmiCubit, BmiState>(
            listener: (context, state) {
              if (state is BmiLoadSuccess) {
                bmiEntity = state.bmiData;
                populateFields(bmiEntity);
              } else if (state is BmiSaveSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('BMI Data Saved Successfully')),
                );
                context.pop();

              } else if (state is BmiSaveFailed) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is BmiLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BmiLoadSuccess || state is BmiSaving) {
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
                        'BMI Screening',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF207D8B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              'Weight (kg)',
                              weightController,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              'Height (cm)',
                              heightController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildTextField('BMI( Kg/m2)', bmiController),
                      const SizedBox(height: 16),
                      _buildMultilineTextField(
                        'Notes (Optional)',
                        notesController,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Additional Body Composition Inputs',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildTwoColumnFields(),
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
                            final bmiRequestBody = _prepareBmiRequest();
                            context.read<BmiCubit>().saveBmi(bmiRequestBody);
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

  Widget _buildTwoColumnFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField('Hydration', hydrationController)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Body Fat', bodyFatController)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextField('Bone Mass', boneMassController)),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField('Muscle Mass', muscleMassController),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                'Visceral Fat Level',
                visceralFatController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField('Metabolic Age', metabolicAgeController),
            ),
          ],
        ),
      ],
    );
  }

  Map<String, dynamic> _prepareBmiRequest() {
    return {
      "name": "BMI",
      "department": "Basic Health Checkup Report",
      "bar_code": patient!.barcode,
      "parameters": [
        _parameter("Height", heightController.text, "Cm"),
        _parameter("Weight", weightController.text, "Kg(s)"),
        _parameter("BMI", bmiController.text, "Kg/m2"),
        _parameter("Hydration", hydrationController.text, "%"),
        _parameter("Fat", bodyFatController.text, "%"),
        _parameter("Bone Mass", boneMassController.text, "%"),
        _parameter("Muscle", muscleMassController.text, "%"),
        _parameter("Visceral Fat", visceralFatController.text, "%"),
        _parameter("Metabolic Age", metabolicAgeController.text, "%"),
      ],
    };
  }

  Map<String, dynamic> _parameter(String name, String value, String unit) {
    return {
      "name": name,
      "uhid": patient!.uhid,
      "bar_code": patient!.barcode,
      "parameter_group_name": "BMI",
      "machine_code": "243671063",
      "value": value,
      "unit": unit,
      "comments": notesController.text,
    };
  }

}
