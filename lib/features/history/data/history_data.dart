import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/features/history/models/carbon_equivalent.dart';
import 'package:smart_carbon_tracking/features/history/models/history_detail_item.dart';
import 'package:smart_carbon_tracking/features/history/models/history_item.dart';

class HistoryData {
  static List<HistoryDetailItem> getDetailItems(String historyId) {
    final Map<String, List<HistoryDetailItem>> detailMap = {
      '1': [
        HistoryDetailItem(name: 'Premium Rice 5kg', quantity: 1, carbonKg: 0.8, icon: HugeIcons.strokeRoundedShoppingBasket01),
        HistoryDetailItem(name: 'Cooking Oil 2L', quantity: 1, carbonKg: 0.5, icon: HugeIcons.strokeRoundedDroplet),
        HistoryDetailItem(name: 'UHT Milk 1L', quantity: 2, carbonKg: 0.6, icon: HugeIcons.strokeRoundedCoffee01),
        HistoryDetailItem(name: 'Eggs 1 Kg', quantity: 1, carbonKg: 0.6, icon: HugeIcons.strokeRoundedCircle),
      ],
      '2': [
        HistoryDetailItem(name: 'Caramel Macchiato', quantity: 1, carbonKg: 0.7, icon: HugeIcons.strokeRoundedCoffee01),
        HistoryDetailItem(name: 'Croissant', quantity: 1, carbonKg: 0.5, icon: HugeIcons.strokeRoundedBread01),
      ],
      '3': [
        HistoryDetailItem(name: 'Beef 500g', quantity: 1, carbonKg: 3.2, icon: HugeIcons.strokeRoundedSteak),
        HistoryDetailItem(name: 'Organic Vegetables', quantity: 3, carbonKg: 0.3, icon: HugeIcons.strokeRoundedBroccoli),
        HistoryDetailItem(name: 'Slice Cheese', quantity: 2, carbonKg: 1.2, icon: HugeIcons.strokeRoundedCheese),
        HistoryDetailItem(name: 'Salmon Fish 300g', quantity: 1, carbonKg: 1.8, icon: HugeIcons.strokeRoundedShoppingBasket01),
        HistoryDetailItem(name: 'Imported Mix Fruit', quantity: 1, carbonKg: 0.9, icon: HugeIcons.strokeRoundedApple01),
        HistoryDetailItem(name: 'Snack Pack', quantity: 4, carbonKg: 1.0, icon: HugeIcons.strokeRoundedShoppingBasket01),
      ],
      '4': [
        HistoryDetailItem(name: 'Gaming Laptop 15"', quantity: 1, carbonKg: 25.0, icon: HugeIcons.strokeRoundedComputerVideo),
      ],
      '5': [
        HistoryDetailItem(name: 'Mineral Water 600ml', quantity: 2, carbonKg: 0.4, icon: HugeIcons.strokeRoundedDroplet),
        HistoryDetailItem(name: 'White Bread', quantity: 1, carbonKg: 0.3, icon: HugeIcons.strokeRoundedBread01),
        HistoryDetailItem(name: 'Liquid Soap', quantity: 1, carbonKg: 1.1, icon: HugeIcons.strokeRoundedDroplet),
      ],
      '6': [
        HistoryDetailItem(name: 'Flight Ticket Jakarta-Bali', quantity: 1, carbonKg: 150.0, icon: HugeIcons.strokeRoundedAirplane01),
      ],
      '7': [
        HistoryDetailItem(name: 'Plain T-Shirt', quantity: 1, carbonKg: 7.0, icon: HugeIcons.strokeRoundedTShirt),
        HistoryDetailItem(name: 'Slim Jeans', quantity: 1, carbonKg: 5.5, icon: HugeIcons.strokeRoundedTShirt),
      ],
      '8': [
        HistoryDetailItem(name: 'Paracetamol 500mg', quantity: 1, carbonKg: 0.2, icon: HugeIcons.strokeRoundedMedicine01),
        HistoryDetailItem(name: 'Vitamin C 1000mg', quantity: 1, carbonKg: 0.2, icon: HugeIcons.strokeRoundedMedicine01),
        HistoryDetailItem(name: 'Medical Mask', quantity: 1, carbonKg: 0.3, icon: HugeIcons.strokeRoundedHospital01),
        HistoryDetailItem(name: 'Hand Sanitizer', quantity: 1, carbonKg: 0.1, icon: HugeIcons.strokeRoundedDroplet),
      ],
      '9': [
        HistoryDetailItem(name: 'Fuel Pertamax 40L', quantity: 1, carbonKg: 45.0, icon: HugeIcons.strokeRoundedCar02),
      ],
    };

    return detailMap[historyId] ?? [];
  }

  // ─── Carbon Equivalents Calculator ───
  static List<CarbonEquivalent> getCarbonEquivalents(double carbonKg) {
    final double kmDriven = carbonKg * 6.1; // ~6.1 km per kg CO2
    final double treeDays = carbonKg / 0.022; // 1 tree absorbs ~22g CO2/day
    final double lightHours = carbonKg / 0.05; // ~50g CO2 per hour for 60W bulb

    return [
      CarbonEquivalent(
        label: 'Driving',
        value: kmDriven.toStringAsFixed(1),
        unit: 'km',
        icon: HugeIcons.strokeRoundedCar02,
        color: const Color(0xFF6366F1),
      ),
      CarbonEquivalent(
        label: 'Tree Absorption',
        value: treeDays.toStringAsFixed(0),
        unit: 'days',
        icon: HugeIcons.strokeRoundedTree06,
        color: const Color(0xFF10B981),
      ),
      CarbonEquivalent(
        label: 'Light Usage',
        value: lightHours.toStringAsFixed(0),
        unit: 'hours',
        icon: HugeIcons.strokeRoundedIdea01,
        color: const Color(0xFFF59E0B),
      ),
    ];
  }

  // ─── Green Tips by Category ───
  static List<String> getGreenTips(String category) {
    final Map<String, List<String>> tipsMap = {
      'Grocery': [
        'Bring your own shopping bag to reduce single-use plastic.',
        'Choose local products to reduce emissions from transportation.',
        'Reduce red meat consumption — try plant-based alternatives.',
        'Buy in bulk to reduce packaging waste.',
      ],
      'Dining': [
        'Bring your own tumbler to reduce single-use cups.',
        'Choose cafes that use fair trade coffee beans.',
        'Avoid food waste — order only what you need.',
      ],
      'Electronics': [
        'Choose devices with Energy Star certification.',
        'Extend device life with regular maintenance.',
        'Donate or recycle old devices properly.',
      ],
      'Travel': [
        'Consider ground transportation for short distances.',
        'Choose airlines with carbon offset programs.',
        'Use public transportation at your destination.',
      ],
      'Fashion': [
        'Choose clothes from organic or recycled materials.',
        'Buy high-quality clothes that last longer.',
        'Try thrift shops to reduce fast fashion impact.',
      ],
      'Health': [
        'Choose health products with eco-friendly packaging.',
        'Use refillable products if available.',
        'Recycle medicine packaging correctly.',
      ],
      'Transport': [
        'Consider electric or hybrid vehicles.',
        'Perform carpooling to reduce emissions per person.',
        'Maintain optimal tire pressure for fuel efficiency.',
        'Use public transportation whenever possible.',
      ],
    };
    return tipsMap[category] ?? [
      'Reduce, reuse, and recycle.',
      'Choose eco-friendly products.',
    ];
  }

  static List<HistoryItem> getMockHistory() {
    return [
      HistoryItem(
        id: '1',
        storeName: 'Indomaret Point',
        category: 'Grocery',
        totalItems: 5,
        totalCarbonKg: 2.5,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        riskLevel: HistoryRiskLevel.low,
        categoryIcon: HugeIcons.strokeRoundedShoppingBasket01,
      ),
      HistoryItem(
        id: '2',
        storeName: 'Starbucks Coffee',
        category: 'Dining',
        totalItems: 2,
        totalCarbonKg: 1.2,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        riskLevel: HistoryRiskLevel.low,
        categoryIcon: HugeIcons.strokeRoundedCoffee01,
      ),
      HistoryItem(
        id: '3',
        storeName: 'Superindo Express',
        category: 'Grocery',
        totalItems: 12,
        totalCarbonKg: 8.4,
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        riskLevel: HistoryRiskLevel.medium,
        categoryIcon: HugeIcons.strokeRoundedShoppingBasket01,
      ),
      HistoryItem(
        id: '4',
        storeName: 'Electronic City',
        category: 'Electronics',
        totalItems: 1,
        totalCarbonKg: 25.0,
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        riskLevel: HistoryRiskLevel.high,
        categoryIcon: HugeIcons.strokeRoundedComputerVideo,
      ),
      HistoryItem(
        id: '5',
        storeName: 'Alfamart',
        category: 'Grocery',
        totalItems: 3,
        totalCarbonKg: 1.8,
        timestamp: DateTime.now().subtract(const Duration(days: 4)),
        riskLevel: HistoryRiskLevel.low,
        categoryIcon: HugeIcons.strokeRoundedShoppingBasket01,
      ),
      HistoryItem(
        id: '6',
        storeName: 'Traveloka',
        category: 'Travel',
        totalItems: 1,
        totalCarbonKg: 150.0,
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
        riskLevel: HistoryRiskLevel.high,
        categoryIcon: HugeIcons.strokeRoundedAirplane01,
      ),
      HistoryItem(
        id: '7',
        storeName: 'Uniqlo',
        category: 'Fashion',
        totalItems: 2,
        totalCarbonKg: 12.5,
        timestamp: DateTime.now().subtract(const Duration(days: 6)),
        riskLevel: HistoryRiskLevel.medium,
        categoryIcon: HugeIcons.strokeRoundedTShirt,
      ),
      HistoryItem(
        id: '8',
        storeName: 'Kimia Farma',
        category: 'Health',
        totalItems: 4,
        totalCarbonKg: 0.8,
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
        riskLevel: HistoryRiskLevel.low,
        categoryIcon: HugeIcons.strokeRoundedHospital01,
      ),
      HistoryItem(
        id: '9',
        storeName: 'Shell Indonesia',
        category: 'Transport',
        totalItems: 1,
        totalCarbonKg: 45.0,
        timestamp: DateTime.now().subtract(const Duration(days: 8)),
        riskLevel: HistoryRiskLevel.high,
        categoryIcon: HugeIcons.strokeRoundedCar02,
      ),
    ];
  }
}
