import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heath_genie/feature/common/widgets/app_genie_button.dart';
import '../../../common/widgets/app_scafold.dart';

class SpyroTestScreen extends StatelessWidget {
  final String? type;
  SpyroTestScreen({super.key, required this.type});

  final TextEditingController test1Controller = TextEditingController();
  final TextEditingController test2Controller = TextEditingController();
  final TextEditingController test3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      username: '$type Test',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('Parameter')),
                  Padding(padding: EdgeInsets.all(8), child: Text('Predicted')),
                  Padding(padding: EdgeInsets.all(8), child: Text('Test 1')),
                  Padding(padding: EdgeInsets.all(8), child: Text('Test 2')),
                  Padding(padding: EdgeInsets.all(8), child: Text('Test 3')),
                  Padding(padding: EdgeInsets.all(8), child: Text('Best')),
                  Padding(padding: EdgeInsets.all(8), child: Text('%Pred')),
                ]),
                TableRow(children: [
                  Padding(padding: EdgeInsets.all(8), child: Text(type!)),
                  Padding(padding: EdgeInsets.all(8), child: Text('3.13')),
                  Padding(padding: EdgeInsets.all(8), child: TextField(controller: test1Controller)),
                  Padding(padding: EdgeInsets.all(8), child: TextField(controller: test2Controller)),
                  Padding(padding: EdgeInsets.all(8), child: TextField(controller: test3Controller)),
                  Padding(padding: EdgeInsets.all(8), child: Text('-')),
                  Padding(padding: EdgeInsets.all(8), child: Text('-')),
                ]),
              ],
            ),
            const SizedBox(height: 20),
            AppGenieButton(
              onPressed: () {
                if (test1Controller.text.isNotEmpty &&
                    test2Controller.text.isNotEmpty &&
                    test3Controller.text.isNotEmpty) {
                  context.pop(true);
                }
              },
              buttonText: 'Save',
              backgroundColor:test1Controller.text.isNotEmpty &&
                  test2Controller.text.isNotEmpty &&
                  test3Controller.text.isNotEmpty? Colors.blue: Colors.white30 ,
            ),
          ],
        ),
      ),
    );
  }
}