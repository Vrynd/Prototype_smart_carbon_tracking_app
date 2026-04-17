import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/history/models/history_item.dart';

class HistoryTile extends StatelessWidget {
  final HistoryItem item;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const HistoryTile({
    super.key,
    required this.item,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppContainer.compact(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              spacing: 12,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item.riskLevel.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: HugeIcon(
                    icon: item.categoryIcon,
                    color: item.riskLevel.color,
                    size: 24,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.storeName,
                        style: context.text.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${item.totalItems} items",
                            style: context.text.bodyMedium?.copyWith(
                              color: context.colors.outline,
                            ),
                          ),
                          const DotSeparator(),
                          Text(
                            item.category,
                            style: context.text.bodyMedium?.copyWith(
                              color: context.colors.outline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${item.totalCarbonKg} kg",
                      style: context.text.titleMedium?.copyWith(
                        color: item.riskLevel.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "CO2e",
                      style: context.text.labelSmall?.copyWith(
                        color: context.colors.outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSpacing.vGap8,
          const DashedDivider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 6,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedCalendar01,
                      size: 16,
                      color: context.colors.outline,
                    ),
                    Text(
                      DateFormat('d MMM yyyy, HH:mm').format(item.timestamp),
                      style: context.text.bodySmall?.copyWith(
                        color: context.colors.outline,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 12,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: item.riskLevel.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item.riskLevel.label,
                        style: context.text.labelSmall?.copyWith(
                          color: item.riskLevel.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (onDelete != null)
                      InkWell(
                        onTap: onDelete,
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedDelete02,
                          size: 20,
                          color: Colors.red.shade400,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}