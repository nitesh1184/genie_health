import 'package:go_router/go_router.dart';
import 'package:heath_genie/feature/common/splash_screen.dart';
import 'package:heath_genie/feature/settings/setting.dart';

import '../../feature/Home/presentation/homepage.dart';
import '../../feature/auth/presentation/UI/login.dart';
import '../../feature/common/bar_code/bar_code_scanner.dart';
import '../../feature/detail/presentation/patient_detail_screen.dart';

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


  ],
);
