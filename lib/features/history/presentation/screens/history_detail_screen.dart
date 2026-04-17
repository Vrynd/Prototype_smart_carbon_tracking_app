import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/history/history.dart';

class HistoryDetailScreen extends StatefulWidget {
  final HistoryItem item;

  const HistoryDetailScreen({super.key, required this.item});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  bool _isConfirmed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<HistoryController>().loadDetail(widget.item);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleDelete() async {
    final confirmed = await AppBottomSheet.showConfirmation(
      context,
      title: 'Delete History',
      subtitle:
          'Are you sure you want to delete this duty from ${widget.item.storeName}? This action cannot be undone.',
      confirmLabel: 'Delete Now',
      cancelLabel: 'Cancel',
      isDanger: true,
    );

    if (!mounted) return;
    if (confirmed == true) {
      context.read<HistoryController>().deleteHistoryItem(widget.item.id);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryController>(
      builder: (context, controller, _) {
        return ScaffoldApp(
          backgroundColor: context.colors.surfaceContainerLow,
          appBar: HeaderApp(
            variant: HeaderVariant.detail,
            title: widget.item.storeName,
          ),
          body: controller.isDetailLoading
              ? const Center(child: CircularProgressIndicator())
              : ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(
                    overscroll: false,
                    physics: const BouncingScrollPhysics(),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    children: [
                      TotalEmission(
                        item: widget.item,
                        averageDailyCarbon: controller.averageDailyCarbon,
                      ),
                      AppSpacing.vGap16,

                      HistoryInfo(item: widget.item),
                      AppSpacing.vGap16,

                      if (controller.detailItems.isNotEmpty) ...[
                        ReceiptBreakdown(
                          items: controller.detailItems,
                          totalCarbonKg: widget.item.totalCarbonKg,
                        ),
                        AppSpacing.vGap16,
                      ],

                      if (controller.carbonEquivalents.isNotEmpty) ...[
                        CarbonContext(
                          equivalents: controller.carbonEquivalents,
                        ),
                        AppSpacing.vGap16,
                      ],

                      if (controller.greenTips.isNotEmpty) ...[
                        GreenTips(
                          tips: controller.greenTips,
                        ),
                      ],
                    ],
                  ),
                ),
          bottomNavigationBar: AppBottomDualAction(
            safetyTitle: 'Permanent Deletion',
            safetySubtitle: 'I agree to delete this history permanently',
            isConfirmed: _isConfirmed,
            onConfirmedChanged: (val) {
              setState(() => _isConfirmed = val);
            },
            primaryLabel: 'Delete History Now',
            onPrimaryPressed: _handleDelete,
            primaryColor: Colors.red.shade400,
            secondaryLabel: 'Share',
            secondaryIcon: HugeIcons.strokeRoundedShare01,
            onSecondaryPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sharing feature is coming soon!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
