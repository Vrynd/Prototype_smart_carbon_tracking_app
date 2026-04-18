import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/features/statistic/data/statistic_data.dart';
import 'package:smart_carbon_tracking/features/statistic/models/carbon_summary.dart';
import 'package:smart_carbon_tracking/features/statistic/models/carbon_activity_point.dart';
import 'package:smart_carbon_tracking/features/statistic/models/category_breakdown.dart';
import 'package:smart_carbon_tracking/features/statistic/models/impact_summary.dart';

class StatisticController extends ChangeNotifier {
  List<CarbonActivityPoint> _activityPoints = [];
  CarbonSummary? _summary;
  List<CategoryBreakdown> _breakdowns = [];
  List<ImpactSummary> _impacts = [];
  bool _isLoading = false;

  List<CarbonActivityPoint> get activityPoints => _activityPoints;
  CarbonSummary? get summary => _summary;
  List<CategoryBreakdown> get breakdowns => _breakdowns;
  List<ImpactSummary> get impacts => _impacts;
  bool get isLoading => _isLoading;

  double get currentMonthEmission => StatisticData.getCurrentMonthEmission();
  double get previousMonthEmission => StatisticData.getPreviousMonthEmission();

  double get monthlyChangePercentage {
    if (previousMonthEmission == 0) return 0;
    return ((currentMonthEmission - previousMonthEmission) / previousMonthEmission * 100);
  }

  bool get isMonthlyIncreased => currentMonthEmission > previousMonthEmission;
  String get periodLabel => 'last 30 days';

  void init() {
    _loadData();
  }

  void _loadData() {
    _isLoading = true;
    notifyListeners();
    _activityPoints = StatisticData.getCarbonActivityDataset();
    _summary = StatisticData.getRecentSummary();
    _breakdowns = StatisticData.getRecentBreakdown();
    _impacts = StatisticData.getRecentImpact();

    _isLoading = false;
    notifyListeners();
  }
}
