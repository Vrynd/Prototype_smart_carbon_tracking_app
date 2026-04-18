import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/features/statistic/models/carbon_summary.dart';
import 'package:smart_carbon_tracking/features/statistic/models/carbon_activity_point.dart';
import 'package:smart_carbon_tracking/features/statistic/models/category_breakdown.dart';
import 'package:smart_carbon_tracking/features/statistic/models/impact_summary.dart';

class StatisticData {
  StatisticData._();

  static CarbonSummary getRecentSummary() {
    return const CarbonSummary(
      totalEmission: 87.3,
      previousPeriodEmission: 95.1,
      dailyAverage: 2.91,
      changePercentage: 8.2,
      isIncreased: false,
    );
  }

  static List<CategoryBreakdown> getRecentBreakdown() {
    return [
      CategoryBreakdown(
        name: 'Transport',
        amount: 28.4,
        percentage: 32.5,
        icon: HugeIcons.strokeRoundedCar01,
        color: const Color(0xFF3B82F6),
      ),
      CategoryBreakdown(
        name: 'Energy',
        amount: 22.1,
        percentage: 25.3,
        icon: HugeIcons.strokeRoundedZap,
        color: const Color(0xFFEAB308),
      ),
      CategoryBreakdown(
        name: 'Food',
        amount: 17.5,
        percentage: 20.0,
        icon: HugeIcons.strokeRoundedCoffee02,
        color: const Color(0xFFF97316),
      ),
      CategoryBreakdown(
        name: 'Shopping',
        amount: 12.8,
        percentage: 14.7,
        icon: HugeIcons.strokeRoundedShoppingBag01,
        color: const Color(0xFFA855F7),
      ),
      CategoryBreakdown(
        name: 'Waste',
        amount: 6.5,
        percentage: 7.5,
        icon: HugeIcons.strokeRoundedWaste,
        color: const Color(0xFF10B981),
      ),
    ];
  }

  static List<ImpactSummary> getRecentImpact() {
    return [
      ImpactSummary(
        label: 'Trees Saved',
        value: '2.4',
        subtitle: 'offset this month',
        icon: HugeIcons.strokeRoundedTree01,
        color: const Color(0xFF10B981),
      ),
      ImpactSummary(
        label: 'Travel Dist.',
        value: '350 km',
        subtitle: 'car drive equiv.',
        icon: HugeIcons.strokeRoundedCar01,
        color: const Color(0xFF3B82F6),
      ),
      ImpactSummary(
        label: 'Coal Saved',
        value: '12 kg',
        subtitle: 'energy source',
        icon: HugeIcons.strokeRoundedFire,
        color: const Color(0xFFF97316),
      ),
      ImpactSummary(
        label: 'Global Rank',
        value: 'Top 5%',
        subtitle: 'among eco users',
        icon: HugeIcons.strokeRoundedStar,
        color: const Color(0xFFA855F7),
      ),
    ];
  }

  static double getCurrentMonthEmission() => 87.3;
  static double getPreviousMonthEmission() => 95.1;

  static List<CarbonActivityPoint> getCarbonActivityDataset() {
    final List<CarbonActivityPoint> dataset = [];
    final now = DateTime.now();
    final firstDayOfYear = DateTime(now.year, 1, 1);
    
    final int daysCount = now.difference(firstDayOfYear).inDays + 1;
    
    for (int i = 0; i < daysCount; i++) {
      final date = firstDayOfYear.add(Duration(days: i));
      final dayName = _getDayLabel(date.weekday);
      final monthName = _getMonthLabel(date.month);
      
      double value = 0;
      final random = math.Random(i + 500);
      final double dice = random.nextDouble();
      
      if (dice > 0.3) {
        if (dice > 0.9) {
          value = 25.0 + random.nextDouble() * 15.0;
        } else if (dice > 0.7) {
          value = 15.0 + random.nextDouble() * 10.0;
        } else if (dice > 0.5) {
          value = 5.0 + random.nextDouble() * 10.0;
        } else {
          value = 1.0 + random.nextDouble() * 4.0;
        }
      }
      
      dataset.add(CarbonActivityPoint(
        label: dayName,
        value: value,
        description: monthName,
        color: _getColorFromValue(value),
      ));
    }
    
    return dataset;
  }

  static Color _getColorFromValue(double value) {
    if (value == 0) return const Color(0xFFF1F5F9);
    
    if (value < 5) {
      return const Color(0xFFE2F3F0);
    } else if (value < 12) {
      return const Color(0xFFB3E0D8);
    } else if (value < 22) {
      return const Color(0xFF4DB6A3);
    } else if (value < 32) {
      return const Color(0xFF00897B);
    } else {
      return const Color(0xFF004D40);
    }
  }

  static String _getDayLabel(int weekday) => switch (weekday) {
    1 => 'Mon', 2 => 'Tue', 3 => 'Wed', 4 => 'Thu', 5 => 'Fri', 6 => 'Sat', 7 => 'Sun',
    _ => '',
  };

  static String _getMonthLabel(int month) => switch (month) {
    1 => 'January', 2 => 'February', 3 => 'March', 4 => 'April', 5 => 'May', 6 => 'June',
    7 => 'July', 8 => 'August', 9 => 'September', 10 => 'October', 11 => 'November', 12 => 'December',
    _ => '',
  };
}
