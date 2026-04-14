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
  bool _showFullHistory = false;

  ActivityPeriod get selectedPeriod => _selectedPeriod;
  ActivityCategory get selectedCategory => _selectedCategory;
  bool get showFullHistory => _showFullHistory;

  bool get hasMoreActivities {
    final activities = filteredActivities;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (final item in activities) {
      final itemDate = DateTime(item.date.year, item.date.month, item.date.day);
      if (itemDate != today && itemDate != yesterday) {
        return true;
      }
    }
    return false;
  }

  List<ActivityItem> get filteredActivities {
    return _allActivities.where((item) {
      final bool categoryMatch =
          _selectedCategory == ActivityCategory.all ||
          item.category == _selectedCategory;

      return categoryMatch;
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

      final String dateStr =
          '${months[item.date.month]} ${item.date.day}, ${item.date.year}';

      final String label;
      if (itemDate == today) {
        label = 'Today, $dateStr';
      } else if (itemDate == yesterday) {
        label = 'Yesterday, $dateStr';
      } else {
        label = dateStr;
      }

      grouped.putIfAbsent(label, () => []).add(item);
    }

    final allGroups = grouped.entries
        .map((e) => ActivityGroup(label: e.key, items: e.value))
        .toList();

    if (!_showFullHistory) {
      return allGroups
          .where(
            (g) =>
                g.label.startsWith('Today') || g.label.startsWith('Yesterday'),
          )
          .toList();
    }

    return allGroups;
  }

  double get totalImpactKg =>
      filteredActivities.fold(0.0, (sum, item) => sum + item.impactKg);

  int get activityCount => filteredActivities.length;

  void toggleFullHistory(bool value) {
    _showFullHistory = value;
    notifyListeners();
  }

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
    _showFullHistory = false;
    // Removed notifyListeners() to prevent crashes when called during dispose()
  }

  void init() {
    _allActivities = HomeData.getRecentActivities();
    // Use microtask to ensure notifyListeners() doesn't clash with build
    Future.microtask(() => notifyListeners());
  }
}
