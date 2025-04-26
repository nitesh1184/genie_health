import 'package:flutter/material.dart';

class ScreeningGrid extends StatelessWidget {
  const ScreeningGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final screenings = [
      ("Blood Pressure", Icons.favorite_border, Color(0xFFFCE9E9)),
      ("BMI Screening", Icons.balance, Color(0xFFE6F1FF)),
      ("Oximeter", Icons.monitor_heart, Color(0xFFE8FFF3)),
      ("Thermometer", Icons.thermostat, Color(0xFFFFF0E6)),
      ("Spirometer", Icons.air, Color(0xFFF1F0FF)),
      ("Stethoscope", Icons.medical_services, Color(0xFFF4EBFF)),
      ("Basic Health Checkup", Icons.health_and_safety, Color(0xFFE6FBF4)),
      ("Audiometric Test", Icons.hearing, Color(0xFFFFF5E5)),
      ("Optometry Test", Icons.remove_red_eye, Color(0xFFE5F7FF)),
      ("Phlebotomy", Icons.bloodtype, Color(0xFFFFE5EB)),
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Available Screenings",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: screenings.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (_, index) {
              final item = screenings[index];
              return Container(
                decoration: BoxDecoration(
                  color: item.$3,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.$2, color: Colors.black54),
                    const SizedBox(height: 8),
                    Text(item.$1,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
