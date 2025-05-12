import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/Depenency_injections/app_injector.dart';
import '../../../common/user/cubit/user_cubit.dart';
import '../../../detail/domain/entity/patient_model.dart';
import '../../../detail/presentation/cubit/patient_detail_cubit.dart';
import '../../../detail/presentation/cubit/patient_detail_state.dart';
import '../../../detail/presentation/widgets/patient_info_card.dart';
import '../../../detail/presentation/widgets/top_bar.dart';
import '../domain/entities/health_check.dart';
import 'cubit/health_check_cubit.dart';
import 'cubit/health_check_state.dart';

class HealthCheckScreen extends StatefulWidget {
  const HealthCheckScreen({super.key});

  @override
  State<HealthCheckScreen> createState() => _HealthCheckScreenState();
}

class _HealthCheckScreenState extends State<HealthCheckScreen> {
  late PatientDetailCubit patientCubit;
  late HealthCheck healthReport;
  Patient? patient;
  late String unit = '';
  final Map<String, TextEditingController> controllers = {};
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController hydrationController = TextEditingController();
  final TextEditingController bodyFatController = TextEditingController();
  final TextEditingController boneMassController = TextEditingController();
  final TextEditingController muscleMassController = TextEditingController();
  final TextEditingController visceralFatController = TextEditingController();
  final TextEditingController systolicController = TextEditingController();
  final TextEditingController diastolicController = TextEditingController();
  final temperatureController = TextEditingController();
  final TextEditingController metabolicAgeController = TextEditingController();
  final TextEditingController basalTextController = TextEditingController();
  final TextEditingController heartSoundController = TextEditingController();
  final TextEditingController abdomenSoundsController = TextEditingController();
  final TextEditingController fefController = TextEditingController();
  final TextEditingController pefController = TextEditingController();
  final TextEditingController fev1Controller = TextEditingController();
  final TextEditingController fev6Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    patientCubit = sl<PatientDetailCubit>();
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void populateFields(HealthCheck report) {
    for (var group in report.arogyaParametersGroup) {
      for (var param in group.arogyaParameter) {
        switch (param.name) {
          case 'Weight':
            weightController.text = param.value;
            break;
          case 'Height':
            heightController.text = param.value;
            unit = param.unit;
            break;
          case 'BMI':
            bmiController.text = param.value;
            break;
          case 'Hydration':
            hydrationController.text = param.value;
            break;
          case 'Body Fat':
            bodyFatController.text = param.value;
            break;
          case 'Body Mass':
            boneMassController.text = param.value;
            break;
          case 'Muscle Mass':
            muscleMassController.text = param.value;
            break;
          case 'Visceral Fat':
            visceralFatController.text = param.value;
            break;
          case 'Metabolic Age':
            metabolicAgeController.text = param.value;
            break;
          case 'Heart Sounds':
            heartSoundController.text = param.value;
            break;
          case 'Abdomen Sounds':
            abdomenSoundsController.text = param.value;
            break;
          case 'Systolic':
            systolicController.text = param.value;
            break;
          case 'Diastolic':
            diastolicController.text = param.value;
            break;
          case 'Temperature':
            temperatureController.text = param.value;
            break;
          case 'FEF':
            fefController.text = param.value;
            break;
          case 'PEF':
            pefController.text = param.value;
            break;
          case 'FEV1':
            fev1Controller.text = param.value;
            break;
          case 'FEV6':
            fev6Controller.text = param.value;
            break;
        }
      }
    }

    if (unit.toLowerCase() == 'cm') {
      final weight = double.tryParse(weightController.text);
      final height = double.tryParse(heightController.text);
      final bmi = calculateBmi(weightKg: weight, heightCm: height);
      bmiController.text = bmi!.toStringAsFixed(2);
    } else {
      final weight = double.tryParse(weightController.text);
      final height = double.tryParse(heightController.text);
      final bmi = calculateBmi(weightKg: weight, heightFeet: height);
      bmiController.text = bmi!.toStringAsFixed(2);
    }
  }

  double? calculateBmi({
    required double? weightKg,
    double? heightCm,
    double? heightFeet,
  }) {
    if (weightKg == null || weightKg <= 0) return null;

    double? heightMeters;

    if (heightCm != null && heightCm > 0) {
      heightMeters = heightCm / 100;
    } else if (heightFeet != null && heightFeet > 0) {
      final heightInCm = heightFeet * 30.48;
      heightMeters = heightInCm / 100;
    }

    if (heightMeters == null || heightMeters <= 0) return null;

    return weightKg / (heightMeters * heightMeters);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final userName = user!.name;

    return MultiBlocProvider(
      providers: [
        BlocProvider<HealthCheckCubit>(
          create: (_) => sl<HealthCheckCubit>()..getReport(),
        ),
        BlocProvider<PatientDetailCubit>(
          create: (_) => patientCubit..getDetails(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: TopBar(title: userName, onBack: () => context.pop()),
          ),
          body: BlocConsumer<HealthCheckCubit, HealthCheckState>(
            listener: (context, state) {
              if (state is HealthCheckLoadSuccess) {
                healthReport = state.report;
                populateFields(healthReport);
              } else if (state is HealthCheckSaveSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data Saved Successfully')),
                );
                context.pop();
              } else if (state is HealthCheckSaveFailed) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is HealthCheckLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HealthCheckLoadSuccess ||
                  state is HealthCheckSaving) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<PatientDetailCubit, PatientDataState>(
                        builder: (context, patientState) {
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
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Basic Health Checkup',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF207D8B),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              'Weight (kg)',
                              weightController,
                              false,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              'Height (cm or feet/inch)',
                              heightController,
                              false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('BMI (Kg/m2)', bmiController, true),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              'Hydration (%)',
                              hydrationController,
                              false,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              'Fat (%)',
                              bodyFatController,
                              false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              'Bonemass (%)',
                              boneMassController,
                              false,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              'muscles (%)',
                              muscleMassController,
                              false,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      _buildTextField('V Fat(%)', visceralFatController, false),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              'Systolic Blood Pressure (mm Hg)',
                              systolicController,
                              false,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              'Diastolic Blood Pressure (mm hg)',
                              diastolicController,
                              false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              'Temperature',
                              temperatureController,
                              false,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              'Metabolic Age',
                              metabolicAgeController,
                              false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        'Basal Metabolic Age',
                        basalTextController,
                        false,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        'Heart Sounds',
                        heartSoundController,
                        false,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        'Abdomen',
                        abdomenSoundsController,
                        false,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField('FEF', fefController, false),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField('PEF', pefController, false),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              'FEV1',
                              fefController,
                              false,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              'FEV 6',
                              fev6Controller,
                              false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => context.pop(),
                              icon: const Icon(Icons.cancel),
                              label: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF005D57),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.lock_outline),
                              label: const Text(
                                'Save Reading',
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

  Widget _buildTextField(
    String title,
    TextEditingController controller,
    bool readOnly,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: TextField(
            readOnly: readOnly,
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(
              decimal: true,
              signed: false,
            ),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              fillColor: readOnly ? Colors.black45 : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
