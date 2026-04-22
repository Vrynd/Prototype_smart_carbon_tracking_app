import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/home/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<HomeController>().init();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        final stats = controller.stats;

        return ScaffoldApp(
          backgroundColor: context.colors.surfaceContainerLow,
          appBar: const HeaderApp(),
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(
              overscroll: false,
              physics: const BouncingScrollPhysics(),
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
              children: [
                if (stats != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DashboardStats(stats: stats),
                  ),
                AppSpacing.vGap24,

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TitleAction.button(
                    title: 'Recent Activity',
                    icon: HugeIcons.strokeRoundedArrowRight02,
                    onTap: () {
                      context.push('/home/recent-activity');
                    },
                  ),
                ),
                AppSpacing.vGap10,

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RecentActivity(
                    activities: controller.recentActivities,
                    isGrouped: true,
                  ),
                ),
                AppSpacing.vGap32,

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TitleAction.standard(
                    title: 'Rekomendasi',
                  ),
                ),
                AppSpacing.vGap10,

                RecommendationsList(items: controller.recommendations),
              ],
            ),
          ),
        );
      },
    );
  }
}
