import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../cubit/patient_detail_state.dart';

class UserInfoCard extends StatelessWidget {
  final PatientDataSuccess state;
  const UserInfoCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Name:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(state.data.name, style: TextStyle(fontSize: 24)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Uhid:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(state.data.uhid, style: TextStyle(fontSize: 24)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Labour ID:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(state.data.labourId, style: TextStyle(fontSize: 24)),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: SfBarcodeGenerator(
              value: state.data.labourId,
              symbology: Code128(),
              showValue: true,
            ),
          ),
        ],
      ),
    );
  }
}
