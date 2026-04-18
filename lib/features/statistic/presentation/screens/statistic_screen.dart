import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/statistic/statistic.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<StatisticController>().init();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StatisticController>(
      builder: (context, controller, _) {
        final summary = controller.summary;

        return ScaffoldApp(
          backgroundColor: context.colors.surfaceContainerLow,
          appBar: const HeaderApp(),
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(
              overscroll: false,
              physics: const BouncingScrollPhysics(),
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                if (summary != null)
                  CarbonOverview(
                    summary: summary,
                    periodLabel: controller.periodLabel,
                  ),
                AppSpacing.vGap16,

                if (summary != null)
                  Row(
                    children: [
                      Expanded(
                        child: AppContainer(
                          borderRadius: 12,
                          padding: EdgeInsets.zero,
                          child: AppSettingTile(
                            variant: TileVariant.classic,
                            icon: HugeIcons.strokeRoundedAnalytics01,
                            title: 'Last Month',
                            subtitle:
                                '${summary.previousPeriodEmission.toStringAsFixed(1)} kg CO₂e',
                            iconColor: context.colors.primary,
                          ),
                        ),
                      ),
                      AppSpacing.hGap16,
                      Expanded(
                        child: AppContainer(
                          borderRadius: 12,
                          padding: EdgeInsets.zero,
                          child: AppSettingTile(
                            variant: TileVariant.classic,
                            icon: HugeIcons.strokeRoundedCalendar03,
                            title: 'Daily Avg',
                            subtitle:
                                '${summary.dailyAverage.toStringAsFixed(1)} kg CO₂e',
                            iconColor: context.colors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                AppSpacing.vGap24,

                TitleAction(
                  title: 'Category Breakdown',
                  subTitle: 'Emission distribution by your activity types',
                  actionType: ActionType.none,
                ),
                AppSpacing.vGap12,
                CarbonEmission(breakdowns: controller.breakdowns),
                AppSpacing.vGap32,

                TitleAction(
                  title: 'Carbon Activity',
                  subTitle: 'Daily emission patterns throughout the year',
                  actionType: ActionType.none,
                ),
                AppSpacing.vGap12,
                CarbonActivityChart(points: controller.activityPoints),
                AppSpacing.vGap24,

                TitleAction(
                  title: 'Impact Summary',
                  subTitle: 'The environmental effect of your efforts',
                  actionType: ActionType.none,
                ),
                AppSpacing.vGap12,
                SustainabilityImpact(impacts: controller.impacts),
              ],
            ),
          ),
        );
      },
    );
  }
}
