import 'package:go_router/go_router.dart';
import 'package:heath_genie/feature/common/splash_screen.dart';
import 'package:heath_genie/feature/settings/setting.dart';

import '../../feature/Home/presentation/homepage.dart';
import '../../feature/auth/presentation/UI/login.dart';
import '../../feature/common/bar_code/bar_code_scanner.dart';
import '../../feature/detail/presentation/patient_detail_screen.dart';
import '../../feature/lab_report/blood_pressure/presentation/screen/blood_pressure_screen.dart';
import '../../feature/lab_report/bmi/presentaion/screens/bmi_screen.dart';
import '../../feature/lab_report/oximeter/presentation/screen/oximeter_screen.dart';
import '../../feature/lab_report/spirometer/presentation/screens/spirometer_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => PatientScreen()),
    GoRoute(
      path: '/scanner',
      builder: (context, state) => const BarcodeScannerScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/patientDetail',
      builder: (context, state) => const PatientDetailScreen(),
    ),
    GoRoute(
      path: '/bmi',
      builder: (context, state) => const BmiScreen(),
    ),
    GoRoute(
      path: '/spirometer',
      builder: (context, state) => const SpirometerScreen(),
    ),

    GoRoute(
      path: '/Oximeter',
      builder: (context, state) => const OximeterScreen(),
    ),

    GoRoute(
      path: '/bp',
      builder: (context, state) => const BloodPressureScreen(),
    ),

  ],
);
