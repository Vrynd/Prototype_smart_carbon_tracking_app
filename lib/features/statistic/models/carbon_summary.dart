class CarbonSummary {
  final double totalEmission;
  final double previousPeriodEmission;
  final double dailyAverage;
  final double changePercentage;
  final bool isIncreased;

  const CarbonSummary({
    required this.totalEmission,
    required this.previousPeriodEmission,
    required this.dailyAverage,
    required this.changePercentage,
    required this.isIncreased,
  });
}
