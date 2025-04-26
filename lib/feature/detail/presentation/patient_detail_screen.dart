import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/detail/presentation/widgets/patient_info_card.dart';
import 'package:heath_genie/feature/detail/presentation/widgets/screening_grid_widget.dart';
import 'package:heath_genie/feature/detail/presentation/widgets/top_bar.dart';
import '../../common/user/cubit/user_cubit.dart';
import 'cubit/patient_detail_cubit.dart';
import 'cubit/patient_detail_state.dart';

class PatientDetailScreen extends StatelessWidget {
  const PatientDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final userName = user!.name;
    final patientCubit = context.read<PatientDetailCubit>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            TopBar(
              username: userName, // Ideally from user data
              onBack: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
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
                        return PatientInfoCard(
                          isExpanded: patientCubit.isExpanded,
                          onToggleExpand: patientCubit.toggleExpandCollapse,
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
          ],
        ),
      ),
    );
  }
}