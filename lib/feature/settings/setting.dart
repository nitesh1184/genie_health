import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/settings/setting_cubit.dart';
import 'package:heath_genie/feature/settings/setting_state.dart';

import '../../core/utils/app_language.dart';
import '../../core/utils/theme_data.dart';
import '../common/widgets/app_scafold.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      username: 'Settings',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: Text('Dark Mode'),
                  value: state.theme == AppTheme.dark,
                  onChanged: (value) {
                    context.read<SettingsCubit>().toggleTheme();
                  },
                );
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.70,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'Select Language',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, state) {
                        return DropdownButton<AppLanguage>(
                          isExpanded: true,
                          value: state.language,
                          onChanged: (language) {
                            if (language != null) {
                              context.read<SettingsCubit>().changeLanguage(
                                language,
                              );
                            }
                          },
                          underline: Container(
                            // Custom underline
                            height: 2,
                            color: Colors.black, // Change color as needed
                          ),
                          items: [
                            DropdownMenuItem(
                              value: AppLanguage.english,
                              child: Text('English'),
                            ),
                            DropdownMenuItem(
                              value: AppLanguage.hindi,
                              child: Text('Hindi'),
                            ),
                          ],
                        );
                      },
                    ),
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
