import 'package:flutter/material.dart' hide SearchBar;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/history/history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  void _showFilterBottomSheet(BuildContext context, HistoryController controller) {
    FilterBottomSheet.show(
      context,
      selectedTab: controller.selectedTab,
      sortBy: controller.sortBy,
      categories: controller.categories,
      onApply: ({category, sortBy}) {
        controller.applyFilters(
          category: category,
          sortBy: sortBy,
        );
      },
    );
  }

  @override  
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<HistoryController>().init();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryController>(
      builder: (context, controller, _) {
        return ScaffoldApp(
          backgroundColor: context.colors.surfaceContainerLow,
          appBar: const HeaderApp(),
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(
              overscroll: false,
              physics: const BouncingScrollPhysics(),
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HistorySummaryCard(
                    totalCarbon: controller.totalCarbonThisMonth,
                    totalScans: controller.totalScansThisMonth,
                  ),
                ),
                AppSpacing.vGap24,

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SearchBar(
                    searchQuery: controller.searchQuery,
                    onSearchChanged: controller.updateSearch,
                    onFilterPressed: () => _showFilterBottomSheet(context, controller),
                    showFilterDot: controller.hasActiveFilters,
                  ),
                ),
                AppSpacing.vGap24,

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TitleAction(
                    title: 'Recent Scans',
                    subTitle: 'A detailed log of your carbon footprint and tracked activities',
                    actionType: ActionType.none,
                  ),
                ),
                AppSpacing.vGap12,

                if (controller.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (controller.filteredHistory.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: AppEmptyState(
                          title: 'No History Found',
                          subtitle:
                              'No receipts match your current filters.',
                        ),
                      ),
                    ),
                  )
                else
                  ...controller.filteredHistory.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: HistoryTile(
                        item: item,
                        onDelete: () => controller.deleteHistoryItem(item.id),
                        onTap: () => context.push('/history/detail', extra: item),
                      ),
                    );
                  }),
              ],
            ),
          ),
        );
      },
    );
  }
}
