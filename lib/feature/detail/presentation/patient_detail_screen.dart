import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heath_genie/feature/detail/presentation/widgets/patient_info_card.dart';
import 'package:heath_genie/feature/detail/presentation/widgets/screening_grid_widget.dart';
import 'package:heath_genie/feature/detail/presentation/widgets/top_bar.dart';
import '../../../core/Depenency_injections/app_injector.dart';
import '../../common/user/cubit/user_cubit.dart';
import 'cubit/patient_detail_cubit.dart';
import 'cubit/patient_detail_state.dart';

class PatientDetailScreen extends StatelessWidget {
  const PatientDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final userName = user!.name;
    final patientCubit = sl<PatientDetailCubit>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            TopBar(
              username: userName, // Ideally from user data
              onBack: () {
                context.pop();
              },
            ),
            BlocProvider(
              create: (_) => patientCubit..getDetails(),
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      BlocBuilder<PatientDetailCubit, PatientDataState>(
                        buildWhen: (previous, current) =>
                        current is PatientExpandCollapseChanged ||
                            current is PatientDataSuccess ||
                            current is PatientDataFailure ||
                            current is PatientDataLoading,
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Patient Information',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        // Handle barcode view
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF245D51),
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      icon: const Icon(Icons.qr_code, size: 18,color: Colors.white),
                                      label: const Text('View Barcode',style: TextStyle(color: Colors.white),),
                                    ),
                                  ],
                                ),
                                PatientInfoCard(
                                  isExpanded: patientCubit.isExpanded,
                                  onToggleExpand: patientCubit.toggleExpandCollapse,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const ScreeningGrid(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}