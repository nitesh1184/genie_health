import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/scanned_patient_list_cubit.dart';
import '../cubit/scanned_patient_list_state.dart';

class ScannedPatientListWidget extends StatelessWidget {
  const ScannedPatientListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannedPatientListCubit, ScannedPatientListState>(
      builder: (context, state) {
        if (state is ScannedPatientListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ScannedPatientListDataFailure) {
          return Center(child: Text(state.message));
        } else if (state is ScannedPatientListDataSuccess) {
          final patients = state.data;
          return ListView.builder(
            itemCount: patients.totalCount,
            itemBuilder: (_, index) {
              final patient = patients.data[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text("${patient.name} (${patient.uhid})"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${patient.age} Y /${patient.gender}'== "M"? 'Male':'Female' ),
                      Text('location - ${DateFormat.yMd('es').format(patient.registrationDate)}'),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('NA'),  // Needs to add department
                      Text('NA'),   // Needs to add risk value
                      Text('NA'),   //Needs to add updated time
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}