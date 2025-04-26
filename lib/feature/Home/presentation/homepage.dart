import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/Home/presentation/widgets/scanned_patient_view_screen.dart';

import '../../../core/Depenency_injections/app_injector.dart';
import 'cubit/patient_tab_cubit.dart';
import 'cubit/scanned_patient_list_cubit.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PatientTabCubit()),
        BlocProvider(
          create: (_) => sl<ScannedPatientListCubit>()..getDetails(),
        ),
      ],
      child: const PatientView(),
    );
  }
}