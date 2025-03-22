import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  BMIScreenState createState() => BMIScreenState();
}

class BMIScreenState extends State<BMIScreen> {
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController hydrationController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController metabolicAgeController = TextEditingController();
  final TextEditingController boneMassController = TextEditingController();
  final TextEditingController musclesController = TextEditingController();
  final TextEditingController visceralFatController = TextEditingController();
  Color bmiColor = Colors.white;
  Color hydrationColor = Colors.white;
  Color fatColor = Colors.white;
  Color musclesColor = Colors.white;
  Color visceralFatColor = Colors.white;
  Color metabolicAgeColor = Colors.white;
  Color boneMassColor = Colors.white;

  void updateColors() {
    setState(() {
      double? bmi = double.tryParse(bmiController.text);
      double? hydration = double.tryParse(hydrationController.text);
      double? fat = double.tryParse(fatController.text);
      double? muscles = double.tryParse(musclesController.text);
      double? visceralFat = double.tryParse(visceralFatController.text);
      double? boneMass = double.tryParse(boneMassController.text);
      double? metabolicAge = double.tryParse(metabolicAgeController.text);

      if (bmi != null) {
        if (bmi < 18 || bmi > 30) {
          bmiColor = Colors.red;
        } else if (bmi >= 18 && bmi <= 27) {
          bmiColor = Colors.green;
        } else {
          bmiColor = Colors.yellow;
        }
      }

      if (hydration != null) {
        if (hydration < 50) {
          hydrationColor = Colors.red;
        } else if (hydration >= 50 && hydration <= 65) {
          hydrationColor = Colors.lightGreen;
        } else {
          hydrationColor = Colors.blue;
        }
      }

      if (boneMass != null) {
        if (boneMass < 3.4) {
          boneMassColor = Colors.red;
        } else if (boneMass >= 3.4 && boneMass <= 5.0) {
          boneMassColor = Colors.lightGreen;
        } else {
          boneMassColor = Colors.blue;
        }
      }

      if (muscles != null) {
        if (muscles < 43.1) {
          musclesColor = Colors.red;
        } else if (muscles >= 43.1 && muscles <= 56.5) {
          musclesColor = Colors.lightGreen;
        } else {
          musclesColor = Colors.blue;
        }
      }

      if (fat != null) {
        if (fat < 12) {
          fatColor = Colors.blue;
        } else if (fat >= 12 && fat < 20) {
          fatColor = Colors.lightGreen;
        } else if (fat >= 20 && fat < 26) {
          fatColor = Colors.yellow;
        } else if (fat >= 26 && fat < 29) {
          fatColor = Colors.orange;
        } else {
          fatColor = Colors.red;
        }
      }

      if (visceralFat != null) {
        if (visceralFat >= 1 && visceralFat <= 12.5) {
          visceralFatColor = Colors.lightGreen;
        } else if (visceralFat >= 13 && visceralFat <= 59) {
          visceralFatColor = Colors.redAccent;
        } else {
          visceralFatColor = Colors.red;
        }
      }

      if (metabolicAge != null) {
        if (metabolicAge < 39) {
          metabolicAgeColor = Colors.lightGreen;
        } else {
          metabolicAgeColor = Colors.red;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI Screening')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: bmiController,
              decoration: InputDecoration(
                labelText: 'BMI',
                fillColor: bmiColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => updateColors(),
            ),
            SizedBox(height: 15),
            TextField(
              controller: hydrationController,
              decoration: InputDecoration(
                labelText: 'Hydration',
                fillColor: hydrationColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => updateColors(),
            ),
            SizedBox(height: 15),
            TextField(
              controller: fatController,
              decoration: InputDecoration(
                labelText: 'Fat',
                fillColor: fatColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => updateColors(),
            ),
            SizedBox(height: 15),
            TextField(
              controller: boneMassController,
              decoration: InputDecoration(
                labelText: 'Bone Mass',
                fillColor: boneMassColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => updateColors(),
            ),
            SizedBox(height: 15),
            TextField(
              controller: musclesController,
              decoration: InputDecoration(
                labelText: 'Muscles',
                fillColor: musclesColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => updateColors(),
            ),
            SizedBox(height: 15),
            TextField(
              controller: visceralFatController,
              decoration: InputDecoration(
                labelText: 'Visceral Fat',
                fillColor: visceralFatColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => updateColors(),
            ),
            SizedBox(height: 15),
            TextField(
              controller: metabolicAgeController,
              decoration: InputDecoration(
                labelText: 'Metabolic Age',
                fillColor: metabolicAgeColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => updateColors(),
            ),
          ],
        ),
      ),
    );
  }
}
