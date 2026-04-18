import 'package:flutter/material.dart';

class CarbonActivityPoint {
  final String label;
  final double value;
  final String? description;
  final Color? color;

  const CarbonActivityPoint({
    required this.label,
    required this.value,
    this.description,
    this.color,
  });
}
