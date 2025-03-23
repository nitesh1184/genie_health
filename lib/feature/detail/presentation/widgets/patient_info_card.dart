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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(state.data.name.string, style: TextStyle(fontSize: 18)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Uhid:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(state.data.uhid.string, style: TextStyle(fontSize: 18)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Labour ID:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(state.data.labourId.string, style: TextStyle(fontSize: 18)),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width * 0.65,
            child: SfBarcodeGenerator(
              value: state.data.labourId.string,
              symbology: Code128(),
              showValue: false,
            ),
          ),
        ],
      ),
    );
  }
}
