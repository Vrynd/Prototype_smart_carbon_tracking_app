import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/history/models/history_detail_item.dart';

class ReceiptBreakdown extends StatefulWidget {
  final List<HistoryDetailItem> items;
  final double totalCarbonKg;

  const ReceiptBreakdown({
    super.key,
    required this.items,
    required this.totalCarbonKg,
  });

  @override
  State<ReceiptBreakdown> createState() => _ReceiptBreakdownState();
}

class _ReceiptBreakdownState extends State<ReceiptBreakdown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      variant: ContainerVariant.basic,
      padding: EdgeInsets.zero,
      backgroundColor: context.colors.surfaceContainerLowest.withValues(alpha: 0.8),
      borderColor: context.colors.surfaceContainerLowest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Receipt Breakdown',
                    style: context.text.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colors.onSurface,
                    ),
                  ),
                  AppSpacing.hGap8,
                  
                  // Item Count Badge (Unified logic: sum of quantities)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: context.colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${widget.items.fold(0, (sum, item) => sum + item.quantity)} Products',
                      style: context.text.labelSmall?.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: _isExpanded ? 0.5 : 0,
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowDown01,
                      color: context.colors.outline,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (_isExpanded) ...[
            const DashedDivider(),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              itemCount: widget.items.length,
              separatorBuilder: (context, index) => AppSpacing.vGap12,
              itemBuilder: (context, index) {
                final HistoryDetailItem item = widget.items[index];
                final double percentage = widget.totalCarbonKg > 0
                    ? (item.carbonKg / widget.totalCarbonKg * 100)
                    : 0;

                Color valueColor = Colors.green;
                if (percentage > 40) {
                  valueColor = Colors.red;
                } else if (percentage > 15) {
                  valueColor = Colors.orange;
                }

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -2),
                  horizontalTitleGap: 12,
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: context.colors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: HugeIcon(
                      icon: item.icon,
                      color: context.colors.primary.withValues(alpha: 0.7),
                      size: 20,
                    ),
                  ),
                  title: Text(
                    item.name,
                    style: context.text.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  subtitle: Text(
                    'Qty: ${item.quantity}',
                    style: context.text.bodySmall?.copyWith(
                      color: context.colors.outline,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${item.carbonKg.toStringAsFixed(1)} kg',
                        style: context.text.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: valueColor,
                        ),
                      ),
                      Text(
                        '${percentage.toStringAsFixed(0)}%',
                        style: context.text.labelSmall?.copyWith(
                          color: context.colors.outline,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
