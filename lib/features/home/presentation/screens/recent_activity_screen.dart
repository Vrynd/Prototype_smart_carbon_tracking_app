import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/home/home.dart';

class RecentActivityScreen extends StatefulWidget {
  const RecentActivityScreen({super.key});

  @override
  State<RecentActivityScreen> createState() => _RecentActivityScreenState();
}

class _RecentActivityScreenState extends State<RecentActivityScreen> {
  late RecentActivityController _controller;

  @override
  void initState() {
    super.initState();
    _controller = context.read<RecentActivityController>();
    _controller.init();
  }

  @override
  void dispose() {
    _controller.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecentActivityController>(
      builder: (context, controller, _) {
        return ScaffoldApp(
          backgroundColor: context.colors.surfaceContainerLow,
          appBar: const HeaderApp(
            title: 'Recent Activity',
            variant: HeaderVariant.detail,
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              controller.showFullHistory ? 64 : 32,
            ),
            children: [
              SummaryBar(
                totalKg: controller.totalImpactKg,
                activityCount: controller.activityCount,
                tag: controller.selectedCategory.label,
                title: 'Activity Summary',
              ),
              AppSpacing.vGap24,

              FilterCategory(
                selectedCategory: controller.selectedCategory,
                onCategoryChanged: controller.setCategory,
              ),
              AppSpacing.vGap24,

              RecentActivity(groups: controller.groupedActivities),
            ],
          ),
          bottomNavigationBar:
              (!controller.showFullHistory && controller.hasMoreActivities)
              ? AppBottomBar(
                  buttonLabel: 'See Older Activities',
                  isConfirmed: true,
                  showDecoration: false,
                  bgColor: context.colors.primary.withValues(alpha: 0.08),
                  fgColor: context.colors.primary,
                  onActionPressed: () => controller.toggleFullHistory(true),
                )
              : null,
        );
      },
    );
  }
}
