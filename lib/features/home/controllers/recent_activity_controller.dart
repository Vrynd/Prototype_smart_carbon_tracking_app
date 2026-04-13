import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/features/home/data/home_data.dart';
import 'package:smart_carbon_tracking/features/home/models/activity_category.dart';
import 'package:smart_carbon_tracking/features/home/models/activity_group.dart';
import 'package:smart_carbon_tracking/features/home/models/activity_item.dart';
import 'package:smart_carbon_tracking/features/home/models/activity_period.dart';

class RecentActivityController extends ChangeNotifier {
  List<ActivityItem> _allActivities = [];
  ActivityPeriod _selectedPeriod = ActivityPeriod.all;
  ActivityCategory _selectedCategory = ActivityCategory.all;

  ActivityPeriod get selectedPeriod => _selectedPeriod;
  ActivityCategory get selectedCategory => _selectedCategory;

  List<ActivityItem> get filteredActivities {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return _allActivities.where((item) {
      final itemDate = DateTime(item.date.year, item.date.month, item.date.day);

      final bool periodMatch = switch (_selectedPeriod) {
        ActivityPeriod.today => itemDate == today,
        ActivityPeriod.thisWeek => !item.date.isBefore(
          today.subtract(const Duration(days: 6)),
        ),
        ActivityPeriod.thisMonth =>
          item.date.year == now.year && item.date.month == now.month,
        ActivityPeriod.all => true,
      };

      final bool categoryMatch =
          _selectedCategory == ActivityCategory.all ||
          item.category == _selectedCategory;

      return periodMatch && categoryMatch;
    }).toList();
  }

  List<ActivityGroup> get groupedActivities {
    final activities = filteredActivities;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final Map<String, List<ActivityItem>> grouped = {};

    for (final item in activities) {
      final itemDate = DateTime(item.date.year, item.date.month, item.date.day);

      final String label;
      if (itemDate == today) {
        label = 'Today';
      } else if (itemDate == yesterday) {
        label = 'Yesterday';
      } else {
        const months = [
          '',
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December',
        ];
        label =
            '${months[item.date.month]} ${item.date.day}, ${item.date.year}';
      }

      grouped.putIfAbsent(label, () => []).add(item);
    }

    return grouped.entries
        .map((e) => ActivityGroup(label: e.key, items: e.value))
        .toList();
  }

  double get totalImpactKg =>
      filteredActivities.fold(0.0, (sum, item) => sum + item.impactKg);

  int get activityCount => filteredActivities.length;

  void setPeriod(ActivityPeriod period) {
    _selectedPeriod = period;
    notifyListeners();
  }

  void setCategory(ActivityCategory category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void reset() {
    _allActivities = [];
    _selectedPeriod = ActivityPeriod.all;
    _selectedCategory = ActivityCategory.all;
    // Removed notifyListeners() to prevent crashes when called during dispose()
  }

  void init() {
    _allActivities = HomeData.getRecentActivities();
    // Use microtask to ensure notifyListeners() doesn't clash with build
    Future.microtask(() => notifyListeners());
  }
}
