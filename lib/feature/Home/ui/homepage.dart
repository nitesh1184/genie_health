import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heath_genie/feature/common/widgets/app_genie_button.dart';
import '../../common/bar_code_cubit.dart';
import '../../common/user/cubit/user_cubit.dart';
import '../../common/widgets/app_scafold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _scanBarcode(BuildContext context) async {
    final String? scannedCode = await context.push('/scanner');
    if (scannedCode != null) {
      context.read<BarcodeCubit>().setBarcode(scannedCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final userName = user!.name;
    final role = user.role;
    final TextEditingController barcodeController = TextEditingController();
    return SafeArea(
      child: AppScaffold(
        username: userName,
        body: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _scanBarcode(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
              ),
              child: const Text('Scan Or Type Bar Code'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocConsumer<BarcodeCubit, String?>(
                listener: (context, barcode) {
                  if(barcode==null || barcode.isEmpty){
                    barcodeController.clear();
                  }
                  else {
                    switch (role) {
                      case 'Doctor':
                        Future.microtask(() => context.push('/doctorScreen'));
                        break;
                      case 'spyro':
                        Future.microtask(() => context.push('/spyroScreen'));
                        break;
                      case 'opto':
                        Future.microtask(() => context.push('/optoScreen'));
                        break;
                      case 'audio':
                        Future.microtask(() => context.push('/audio'));
                        break;
                      default:
                        Future.microtask(() => context.push('/doctor'));
                    } // Navigate to HomeScreen
                  }
                },
                builder: (context, barcode) {
                  barcodeController.text = barcode ?? '';
                  return TextField(
                    controller: barcodeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter or Scan Barcode',
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            AppGenieButton(
              onPressed:
                  () => context.read<BarcodeCubit>().setBarcode(
                    barcodeController.text,
                  ),
              buttonText: 'Submit',
              backgroundColor: Colors.blue,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Powered by'),
                Image.asset('assets/images/buildgenie_logo.png', height: 30),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
