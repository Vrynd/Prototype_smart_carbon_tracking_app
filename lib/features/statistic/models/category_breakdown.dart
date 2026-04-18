import 'package:flutter/material.dart';

class CategoryBreakdown {
  final String name;
  final double amount;
  final double percentage;
  final dynamic icon;
  final Color color;

  const CategoryBreakdown({
    required this.name,
    required this.amount,
    required this.percentage,
    required this.icon,
    required this.color,
  });
}
