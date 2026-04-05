import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/scaffold_app.dart';
import 'package:smart_carbon_tracking/features/home/presentation/screens/home_screen.dart';
import 'package:smart_carbon_tracking/features/navigation/controllers/bottom_bar_controller.dart';
import 'package:smart_carbon_tracking/features/navigation/presentation/widgets/placeholder_nav.dart';
import 'package:smart_carbon_tracking/features/scan/presentation/screens/scan_screen.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/screens/setting_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<dynamic> iconList = [
    HugeIcons.strokeRoundedHome01,
    HugeIcons.strokeRoundedAnalytics01,
    HugeIcons.strokeRoundedClock01,
    HugeIcons.strokeRoundedUser,
  ];

  @override
  Widget build(BuildContext context) {
    final color = context.colors;

    return Consumer<BottomBarController>(
      builder: (context, nav, child) {
        return ScaffoldApp(
          body: IndexedStack(
            index: nav.selectedIndex,
            children: [
              const HomeScreen(),
              const PlaceholderNav(title: 'Statistic'),
              const PlaceholderNav(title: 'History'),
              const SettingScreen(),
            ],
          ),
          floatingActionButton: Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.primary.withValues(alpha: 0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanScreen()),
                );
              },
              backgroundColor: color.primary,
              elevation: 0,
              shape: const CircleBorder(),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedQrCode01,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            itemCount: iconList.length,
            height: 80,
            tabBuilder: (int index, bool isActive) {
              final colorIcon = isActive ? color.primary : Colors.grey.shade400;
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HugeIcon(icon: iconList[index], color: colorIcon, size: 24),
                  const SizedBox(height: 4),
                  Text(
                    index == 0
                        ? 'Home'
                        : index == 1
                        ? 'Statistic'
                        : index == 2
                        ? 'History'
                        : 'Profile',
                    style: context.text.labelLarge?.copyWith(
                      color: colorIcon,
                      fontWeight: isActive ? FontWeight.w900 : FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
            backgroundColor: context.colors.surfaceContainerLowest,
            activeIndex: nav.selectedIndex,
            splashColor: color.primary,
            notchAndCornersAnimation: null,
            splashSpeedInMilliseconds: 300,
            notchSmoothness: NotchSmoothness.softEdge,
            gapLocation: GapLocation.center,
            onTap: (index) => nav.setSelectedIndex(index),
          ),
        );
      },
    );
  }
}
