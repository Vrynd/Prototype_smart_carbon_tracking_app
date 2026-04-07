import 'package:go_router/go_router.dart';
import 'package:smart_carbon_tracking/features/navigation/presentation/screens/navigation_screen.dart';
import 'package:smart_carbon_tracking/features/scan/presentation/screens/scan_screen.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/screens/change_password_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'navigation',
        builder: (context, state) => const NavigationScreen(),
      ),
      GoRoute(
        path: '/scan',
        name: 'scan',
        builder: (context, state) => const ScanScreen(),
      ),
      GoRoute(
        path: '/settings/change-password',
        name: 'change-password',
        builder: (context, state) => const ChangePasswordScreen(),
      ),
    ],
  );
}
