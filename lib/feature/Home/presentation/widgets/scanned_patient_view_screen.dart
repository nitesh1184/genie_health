import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/user/cubit/user_cubit.dart';
import '../cubit/patient_tab_cubit.dart';
import 'bar_code_scanner_tab.dart';
import 'manual_entry_tab.dart';

class PatientView extends StatelessWidget {
  const PatientView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final userName = user!.name;
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF00695C),
        title:Text("Welcome $userName",style: TextStyle(color: Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.teal,
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                _logout(context);
              },
              child: const Text("Logout"),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 4),
            child: Text(
              "Find Patient",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 16),
            child: Text(
              "Scan patient barcode or enter ID manually",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          Center(
            child: Container(
              height: 42,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: BlocBuilder<PatientTabCubit, int>(
                builder: (context, selectedIndex) {
                  return Row(
                    children: [
                      _buildTabButton(context, "Scan Barcode", 0, selectedIndex),
                      _buildTabButton(context, "Manual Entry", 1, selectedIndex),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<PatientTabCubit, int>(
              builder: (context, tabIndex) {
                return tabIndex == 0 ? const ScanBarcodeTab() : const ManualEntryTab();
              },
            ),
          )
        ],
      ),
    );
  }

  Expanded _buildTabButton(BuildContext context, String text, int index, int selectedIndex) {
    final isSelected = index == selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<PatientTabCubit>().switchTab(index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00695C) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _logout(BuildContext context) async {
    final go = context.go; // Capture before await
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    go('/login'); // Use safely after async
  }
}