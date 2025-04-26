import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bar_code/bar_code_cubit.dart';
import '../user/cubit/user_cubit.dart';
import 'genie_app_bar.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String username;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  AppScaffold({super.key, required this.body, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: GenieAppBar(username: username, scaffoldKey: scaffoldKey),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[700]),
              child: const Text(
                textAlign: TextAlign.center,
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                context.go('/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Logout"),
              onTap: () {
                if (context.mounted) {
                  _logout(context);
                }
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored user data

    context.read<BarcodeCubit>().setBarcode(null); // Reset barcode
    context.read<UserCubit>().clearUser(); // Reset user data
    context.go('/'); // Go to login and clear navigation stack
  }
}
