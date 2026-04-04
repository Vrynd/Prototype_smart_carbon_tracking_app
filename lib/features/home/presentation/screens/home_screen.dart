import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/header_app.dart';
import 'package:smart_carbon_tracking/core/widgets/scaffold_app.dart';
import 'package:smart_carbon_tracking/features/home/presentation/widgets/dashboard_stats.dart';
import 'package:smart_carbon_tracking/features/home/presentation/widgets/daily_tips.dart';
import 'package:smart_carbon_tracking/features/home/presentation/widgets/recent_activity.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldApp(
      backgroundColor: context.colors.surfaceContainerLow,
      appBar: const HeaderApp(),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          overscroll: false,
          physics: const BouncingScrollPhysics(),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          children: [
            const DashboardStats(
              ecoScore: '3,492',
              scanStreak: '5 Days',
              lastScan: '+1.2kg',
              planetImpact: '12 Trees',
            ),
            const SizedBox(height: 24),
            DailyTips(
              title: 'Switch to LED Bulbs',
              description: 'Save up to 80% more energy with LED lighting.',
              icon: HugeIcons.strokeRoundedIdea01,
              impact: '-1.2kg CO2',
            ),
            const SizedBox(height: 24),
            RecentActivity(
              onSeeAllTap: () {},
              activities: [
                ActivityItemData(
                  title: 'Starbucks Coffee',
                  subtitle: 'Food & Drink • Today, 10:24',
                  impact: '+0.5kg',
                  icon: HugeIcons.strokeRoundedCoffee02,
                  iconColor: Colors.brown.shade400,
                ),
                ActivityItemData(
                  title: 'Grab Ride',
                  subtitle: 'Transport • Today, 08:15',
                  impact: '+2.3kg',
                  icon: HugeIcons.strokeRoundedCar01,
                  iconColor: Colors.blue.shade400,
                ),
                ActivityItemData(
                  title: 'Groceries Store',
                  subtitle: 'Shopping • Yesterday, 19:40',
                  impact: '+1.8kg',
                  icon: HugeIcons.strokeRoundedShoppingBag01,
                  iconColor: Colors.orange.shade400,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
