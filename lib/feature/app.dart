import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:heath_genie/feature/detail/presentation/cubit/spyro_cubit.dart';
import 'package:heath_genie/feature/settings/setting_cubit.dart';
import 'package:heath_genie/feature/settings/setting_state.dart';
import '../core/localization/generated/strings.dart';
import '../core/localization/l10n.dart';
import '../core/router/app_route.dart';
import '../core/utils/theme_data.dart';
import 'common/bar_code/bar_code_cubit.dart';
import 'common/user/cubit/user_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          create: (BuildContext context) => SettingsCubit(),
        ),
        BlocProvider<BarcodeCubit>(
          create: (BuildContext context) => BarcodeCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit()..loadUser(),
        ),
        BlocProvider(
          create: (context) => SpyroCubit(),
        ), // Global UserCubit// Screen-Specific Cubit
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            title: 'Genie Health',
            debugShowCheckedModeBanner: false,
            theme:
                themeState.theme == AppTheme.dark
                    ? ThemeData.dark()
                    : ThemeData.light(),
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              Strings.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: router,
          );
        },
      ),
    );
  }
}
