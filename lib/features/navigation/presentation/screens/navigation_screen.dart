import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/scaffold_app.dart';
import 'package:smart_carbon_tracking/features/home/presentation/screens/home_screen.dart';
import 'package:smart_carbon_tracking/features/navigation/controllers/bottom_bar_controller.dart';
import 'package:smart_carbon_tracking/features/navigation/presentation/widgets/placeholder_nav.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    final color = context.colors;
    final textStyle = context.text;

    return Consumer<BottomBarController>(
      builder: (context, nav, child) {
        return ScaffoldApp(
          body: IndexedStack(
            index: nav.selectedIndex,
            children: [
              const HomeScreen(),
              const PlaceholderNav(title: 'Scan'),
              const PlaceholderNav(title: 'Statistic'),
              const PlaceholderNav(title: 'Profile'),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: context.colors.surface,
              boxShadow: [
                BoxShadow(
                  color: context.colors.shadow.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: SalomonBottomBar(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                currentIndex: nav.selectedIndex,
                onTap: (i) => nav.setSelectedIndex(i),
                items: [
                  SalomonBottomBarItem(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedHome01,
                      color: Colors.grey.shade400,
                    ),
                    activeIcon: HugeIcon(
                      icon: HugeIcons.strokeRoundedHome01,
                      color: color.primary,
                    ),
                    title: Text("Home", style: textStyle.labelLarge),
                    selectedColor: color.primary,
                  ),
                  SalomonBottomBarItem(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedAiView,
                      color: Colors.grey.shade400,
                    ),
                    activeIcon: HugeIcon(
                      icon: HugeIcons.strokeRoundedAiView,
                      color: color.primary,
                    ),
                    title: Text("Scan", style: textStyle.labelLarge),
                    selectedColor: color.primary,
                  ),
                  SalomonBottomBarItem(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedAnalytics01,
                      color: Colors.grey.shade400,
                    ),
                    activeIcon: HugeIcon(
                      icon: HugeIcons.strokeRoundedAnalytics01,
                      color: color.primary,
                    ),
                    title: Text("Stats", style: textStyle.labelLarge),
                    selectedColor: color.primary,
                  ),
                  SalomonBottomBarItem(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedUser,
                      color: Colors.grey.shade400,
                    ),
                    activeIcon: HugeIcon(
                      icon: HugeIcons.strokeRoundedUser,
                      color: color.primary,
                    ),
                    title: Text("Profile", style: textStyle.labelLarge),
                    selectedColor: color.primary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

