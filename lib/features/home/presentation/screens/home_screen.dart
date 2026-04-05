import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/header_app.dart';
import 'package:smart_carbon_tracking/core/widgets/scaffold_app.dart';
import 'package:smart_carbon_tracking/core/widgets/title_action.dart';
import 'package:smart_carbon_tracking/features/home/presentation/widgets/dashboard_stats.dart';
import 'package:smart_carbon_tracking/features/home/presentation/widgets/recent_activity.dart';
import 'package:smart_carbon_tracking/features/home/presentation/widgets/recommendations_list.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: DashboardStats(
                ecoScore: '3,492',
                scanStreak: '5 Days',
                lastScan: '+1.2kg',
                planetImpact: '12 Trees',
              ),
            ),
            AppSpacing.vGap32,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TitleAction(
                title: 'Rekomendasi',
                actionType: ActionType.dots,
                dotCount: 4,
              ),
            ),
            AppSpacing.vGap10,

            RecommendationsList(
              items: [
                const RecommendationItem(
                  title: 'Common Transport',
                  category: 'Transport',
                  impact: '-2.5 kg',
                  icon: HugeIcons.strokeRoundedBus01,
                  color: Colors.blue,
                ),
                const RecommendationItem(
                  title: 'Plant-Based Diet',
                  category: 'Food',
                  impact: '-1.8 kg',
                  icon: HugeIcons.strokeRoundedLeaf01,
                  color: Colors.green,
                ),
                const RecommendationItem(
                  title: 'Switch to LED',
                  category: 'Energy',
                  impact: '-0.9 kg',
                  icon: HugeIcons.strokeRoundedAiIdea,
                  color: Colors.orange,
                ),
                const RecommendationItem(
                  title: 'Say No to Plastic',
                  category: 'Waste',
                  impact: '-0.5 kg',
                  icon: HugeIcons.strokeRoundedWaste,
                  color: Colors.purple,
                ),
              ],
            ),
            AppSpacing.vGap32,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TitleAction(
                title: 'Recent Activity',
                iconAction: HugeIcons.strokeRoundedArrowRight02,
                actionType: ActionType.elevated,
                onPressed: () {},
              ),
            ),
            AppSpacing.vGap10,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RecentActivity(
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
            ),
            AppSpacing.vGap32,
          ],
        ),
      ),
    );
  }
}
