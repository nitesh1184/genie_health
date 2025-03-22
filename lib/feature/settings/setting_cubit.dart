import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/settings/setting_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/app_language.dart';
import '../../core/utils/theme_data.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(theme: AppTheme.light, language: AppLanguage.english)) {
    _loadSettings();
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getBool('isDark') ?? false;
    final language = prefs.getString('language') ?? 'english';

    emit(SettingsState(
      theme: theme ? AppTheme.dark : AppTheme.light,
      language: language == 'hindi' ? AppLanguage.hindi : AppLanguage.english,
    ));
  }

  void toggleTheme() async {
    final isDark = state.theme == AppTheme.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
    emit(SettingsState(theme: isDark ? AppTheme.dark : AppTheme.light, language: state.language));
  }

  void changeLanguage(AppLanguage language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language == AppLanguage.hindi ? 'hindi' : 'english');
    emit(SettingsState(theme: state.theme, language: language));
  }
}
