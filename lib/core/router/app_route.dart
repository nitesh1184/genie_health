import 'package:go_router/go_router.dart';
import 'package:heath_genie/feature/detail/presentation/screens/audio_screen.dart';
import 'package:heath_genie/feature/detail/presentation/widgets/oxymeter_screen.dart';
import 'package:heath_genie/feature/settings/setting.dart';

import '../../feature/Home/ui/homepage.dart';
import '../../feature/auth/presentation/UI/login.dart';
import '../../feature/common/bar_code_scanner.dart';
import '../../feature/detail/presentation/screens/doctor_screen.dart';
import '../../feature/detail/presentation/screens/opto_screen.dart';
import '../../feature/detail/presentation/screens/spyro_screen.dart';
import '../../feature/detail/presentation/widgets/blood_pressure_screening.dart';
import '../../feature/detail/presentation/widgets/bmi_screen.dart';
import '../../feature/detail/presentation/widgets/spyro_test.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/scanner',
      builder: (context, state) => const BarcodeScannerScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/doctorScreen',
      builder: (context, state) => const DoctorDetailScreen(),
    ),
    GoRoute(path: '/spyroScreen', builder: (context, state) => SpyroScreen()),
    GoRoute(
      path: '/bpScreening',
      builder: (context, state) => const BloodPressureScreen(),
    ),
    GoRoute(
      path: '/oximeter',
      builder: (context, state) => const OxiMeterScreen(),
    ),
    GoRoute(path: '/audio', builder: (context, state) => const AudioScreen()),
    GoRoute(path: '/BmiScreen', builder: (context, state) => const BMIScreen()),
    GoRoute(
      path: '/optoScreen',
      builder: (context, state) => const OptoDetailScreen(),
    ),

    GoRoute(
      path: '/spyroTest/:type',
      name: 'spyroTest',
      builder:
          (context, state) =>
              SpyroTestScreen(type: state.pathParameters['type']),
    ),
  ],
);
