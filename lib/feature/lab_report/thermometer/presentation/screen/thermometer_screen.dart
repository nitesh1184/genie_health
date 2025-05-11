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
import '../../domain/entity/thermometer_entity.dart';
import '../cubit/thermometer_cubit.dart';
import '../cubit/thermometer_state.dart';

class ThermometerScreen extends StatefulWidget {
  const ThermometerScreen({super.key});

  @override
  State<ThermometerScreen> createState() => _ThermometerScreenState();
}

class _ThermometerScreenState extends State<ThermometerScreen> {
  final temperatureController = TextEditingController();
  final notesController = TextEditingController();
  late PatientDetailCubit patientCubit;
  late ThermometerCubit thermometerCubit;
  Patient? patient;

  bool isCelsius = true;
  String unitLabel = '°C';
  String toggleText = 'Switch to °F';

  @override
  void initState() {
    super.initState();
    patientCubit = sl<PatientDetailCubit>();
    thermometerCubit = sl<ThermometerCubit>();
  }

  void populateFields(ThermometerEntity report) {
    for (var param in report.parameters) {
      if (param.name == 'Temperature') {
        temperatureController.text = param.value;
        notesController.text = param.comments;
        isCelsius = param.unit == 'C';
        unitLabel = isCelsius ? '°C' : '°F';
        toggleText = isCelsius ? 'Switch to °F' : 'Switch to °C';
        thermometerCubit.setInitialUnit(isCelsius);
      }
    }
  }

  @override
  void dispose() {
    temperatureController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final userName = user!.name;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => thermometerCubit..getThermometerReport()),
        BlocProvider(create: (_) => patientCubit..getDetails()),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: TopBar(
              title: userName,
              onBack: () => context.pop(),
            ),
          ),
          body: BlocConsumer<ThermometerCubit, ThermometerState>(
            listener: (context, state) {
              if (state is ThermometerLoadSuccess) {
                populateFields(state.thermometerData);
              } else if (state is ThermometerSaveSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Temperature saved successfully')),
                );
                context.pop();
              } else if (state is ThermometerSaveFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is ThermometerUnitChanged) {
                setState(() {
                  isCelsius = state.isCelsius;
                  unitLabel = isCelsius ? '°C' : '°F';
                  toggleText = isCelsius ? 'Switch to °F' : 'Switch to °C';
                  temperatureController.clear();
                });
              }
            },
            builder: (context, state) {
              if (state is ThermometerLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<PatientDetailCubit, PatientDataState>(
                      builder: (context, patientState) {
                        if (patientState is PatientDataSuccess && patient == null) {
                          patient = patientState.data;
                        }
                        return PatientInfoCard(
                          isExpanded: patientState is PatientDataSuccess
                              ? patientState.isExpanded
                              : false,
                          onToggleExpand: () => patientCubit.toggleExpandCollapse(),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Thermometer",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          OutlinedButton(
                            onPressed: () => thermometerCubit.toggleUnit(),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF006D68),
                              side: const BorderSide(color: Color(0xFF006D68)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              textStyle: const TextStyle(fontSize: 13),
                            ),
                            child: Text(toggleText),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Temperature ($unitLabel)',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: temperatureController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: notesController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Notes (Optional)',
                        border: OutlineInputBorder(),
                      ),
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
                              // TODO: Add device view logic
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
                          final request = _prepareRequest(isCelsius ? 'C' : 'F');
                          context.read<ThermometerCubit>().saveParameter(request);
                        },
                        child: const Text('Save Reading'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }


Map<String, dynamic> _prepareRequest(String unit) {
    return {
      "name": "THERMOMETER",
      "department": "Basic Health Checkup Report",
      "bar_code": patient!.barcode,
      "parameters": [
        _parameter("Temperature", temperatureController.text, unit),
      ],
    };
  }

  Map<String, dynamic> _parameter(String name, String value, String unit) {
    return {
      "name": name,
      "uhid": patient!.uhid,
      "bar_code": patient!.barcode,
      "parameter_group_name": "THERMOMETER",
      "machine_code": "",
      "value": value,
      "unit": unit,
      "comments": notesController.text,
    };
  }
}
