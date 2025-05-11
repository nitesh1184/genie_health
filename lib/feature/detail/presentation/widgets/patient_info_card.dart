import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/detail/presentation/widgets/patient_info_item.dart';

import '../cubit/patient_detail_cubit.dart';
import '../cubit/patient_detail_state.dart';

class PatientInfoCard extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggleExpand;

  const PatientInfoCard({
    super.key,
    required this.isExpanded,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    int randomNum = 1 + Random().nextInt((6 + 1) - 1);
    return BlocBuilder<PatientDetailCubit, PatientDataState>(
      builder: (context, state) {
        if (state is PatientDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PatientDataFailure) {
          return Center(child: Text(state.message));
        } else if (state is PatientDataSuccess) {
          final patient = state.data;
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PatientInfoItem(title: 'Name', value: patient.name),
                            if (isExpanded)
                              PatientInfoItem(title: 'Labour ID', value: patient.labourId),
                            if (isExpanded)
                              PatientInfoItem(
                                  title: 'Gender',
                                  value: patient.gender == 'M' ? 'Male' : 'Female'),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Right Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PatientInfoItem(title: 'UHID', value: patient.uhid),
                            if (isExpanded)
                              PatientInfoItem(title: 'Age', value: '${patient.age} years'),
                            if (isExpanded)
                              PatientInfoItem(title: 'Last Visit', value: '$randomNum Weeks ago'),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Icon at bottom right
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: onToggleExpand,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
