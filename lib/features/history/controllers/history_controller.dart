import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/features/history/data/history_data.dart';
import 'package:smart_carbon_tracking/features/history/models/carbon_equivalent.dart';
import 'package:smart_carbon_tracking/features/history/models/history_detail_item.dart';
import 'package:smart_carbon_tracking/features/history/models/history_item.dart';

class HistoryController extends ChangeNotifier {
  List<HistoryItem> _allHistory = [];
  String _searchQuery = '';
  String _selectedTab = 'All';
  String _sortBy = 'newest'; // newest, emission
  
  bool _isLoading = false;

  // ─── Detail State ───
  HistoryItem? _selectedItem;
  List<HistoryDetailItem> _detailItems = [];
  List<CarbonEquivalent> _carbonEquivalents = [];
  List<String> _greenTips = [];
  bool _isDetailLoading = false;

  List<HistoryItem> get allHistory => _allHistory;
  String get searchQuery => _searchQuery;
  String get selectedTab => _selectedTab;
  String get sortBy => _sortBy;
  bool get isLoading => _isLoading;

  // ─── Detail Getters ───
  HistoryItem? get selectedItem => _selectedItem;
  List<HistoryDetailItem> get detailItems => _detailItems;
  List<CarbonEquivalent> get carbonEquivalents => _carbonEquivalents;
  List<String> get greenTips => _greenTips;
  bool get isDetailLoading => _isDetailLoading;

  bool get hasActiveFilters => 
      _selectedTab != 'All' || 
      _sortBy != 'newest';

  final List<String> categories = [
    'All',
    'Grocery',
    'Dining',
    'Electronics',
    'Travel',
    'Fashion',
    'Health',
    'Transport',
  ];

  void init() {
    _isLoading = true;
    notifyListeners();
    
    // Simulate data fetch
    _allHistory = HistoryData.getMockHistory();
    _isLoading = false;
    notifyListeners();
  }

  // ─── Detail Methods ───
  void loadDetail(HistoryItem item) {
    _isDetailLoading = true;
    _selectedItem = item;
    notifyListeners();

    _detailItems = HistoryData.getDetailItems(item.id);
    _carbonEquivalents = HistoryData.getCarbonEquivalents(item.totalCarbonKg);
    _greenTips = HistoryData.getGreenTips(item.category);

    _isDetailLoading = false;
    notifyListeners();
  }

  void clearDetail() {
    _selectedItem = null;
    _detailItems = [];
    _carbonEquivalents = [];
    _greenTips = [];
    _isDetailLoading = false;
    notifyListeners();
  }

  /// Rata-rata emisi harian (total / 30 hari)
  double get averageDailyCarbon {
    if (_allHistory.isEmpty) return 0;
    return totalCarbonThisMonth / 30;
  }

  List<HistoryItem> get filteredHistory {
    List<HistoryItem> filtered = _allHistory.where((item) {
      final matchesSearch = item.storeName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.category.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesTab = _selectedTab == 'All' || item.category == _selectedTab;
      
      return matchesSearch && matchesTab;
    }).toList();

    // Apply sorting
    if (_sortBy == 'newest') {
      filtered.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    } else if (_sortBy == 'emission') {
      filtered.sort((a, b) => b.totalCarbonKg.compareTo(a.totalCarbonKg));
    }

    return filtered;
  }

  double get totalCarbonThisMonth {
    // In real app, filter items in current month
    return _allHistory.fold(0, (sum, item) => sum + item.totalCarbonKg);
  }

  int get totalScansThisMonth {
    return _allHistory.length;
  }

  void updateSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void applyFilters({
    String? category,
    String? sortBy,
  }) {
    if (category != null) _selectedTab = category;
    if (sortBy != null) _sortBy = sortBy;
    notifyListeners();
  }

  void deleteHistoryItem(String id) {
    _allHistory.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
