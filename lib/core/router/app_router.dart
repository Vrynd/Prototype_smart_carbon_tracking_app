import 'package:go_router/go_router.dart';
import 'package:smart_carbon_tracking/features/history/models/history_item.dart';
import 'package:smart_carbon_tracking/features/history/presentation/screens/history_detail_screen.dart';
import 'package:smart_carbon_tracking/features/history/presentation/screens/history_screen.dart';
import 'package:smart_carbon_tracking/features/home/presentation/screens/recent_activity_screen.dart';
import 'package:smart_carbon_tracking/features/navigation/presentation/screens/navigation_screen.dart';
import 'package:smart_carbon_tracking/features/scan/presentation/screens/scan_screen.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/screens/change_password_screen.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/screens/privacy_settings_screen.dart';

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
      GoRoute(
        path: '/settings/privacy',
        name: 'privacy',
        builder: (context, state) => const PrivacySettingsScreen(),
      ),
      GoRoute(
        path: '/home/recent-activity',
        name: 'recent-activity',
        builder: (context, state) => const RecentActivityScreen(),
      ),
      GoRoute(
        path: '/history',
        name: 'history',
        builder: (context, state) => const HistoryScreen(),
        routes: [
          GoRoute(
            path: 'detail',
            name: 'history-detail',
            builder: (context, state) {
              final item = state.extra as HistoryItem;
              return HistoryDetailScreen(item: item);
            },
          ),
        ],
      ),
    ],
  );

  static String getRouteTitle(String? name, [int? tabIndex, dynamic extra]) {
    switch (name) {
      case 'navigation':
        switch (tabIndex) {
          case 0:
            return 'DashBoard';
          case 1:
            return 'Statistic';
          case 2:
            return 'Receipts History';
          case 3:
            return 'Settings';
          default:
            return 'DashBoard';
        }
        
      case 'scan':
        return 'Scan Carbon';
      case 'change-password':
        return 'Change Password';
      case 'privacy':
        return 'Privacy Settings';
      case 'recent-activity':
        return 'Recent Activity';
      case 'history':
        return 'Scan History';
      case 'history-detail':
        return extra is HistoryItem ? extra.storeName : 'Receipt Detail';
      default:
        return 'DashBoard';
    }
  }
}
