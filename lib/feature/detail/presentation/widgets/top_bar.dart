import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final bool isPrefixAdded;

  const TopBar({required this.title, required this.onBack,required this.isPrefixAdded, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A6360),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Color(0xFF0A6360)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isPrefixAdded?'Welcome $title':title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          ElevatedButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0A6360),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}