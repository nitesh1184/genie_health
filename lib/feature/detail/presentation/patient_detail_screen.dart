import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/detail/presentation/widgets/patient_info_card.dart';
import 'package:heath_genie/feature/detail/presentation/widgets/screening_grid_widget.dart';
import 'package:heath_genie/feature/detail/presentation/widgets/top_bar.dart';

import 'cubit/patient_detail_cubit.dart';

class PatientDetailScreen extends StatefulWidget {
  const PatientDetailScreen({super.key});

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  bool isExpanded = true;

  @override
  void initState() {
    super.initState();
    context.read<PatientDetailCubit>().getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            TopBar(
              username: "docyadt1", // Ideally this should come from cubit/user data
              onBack: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    PatientInfoCard(
                      isExpanded: isExpanded,
                      onToggleExpand: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
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