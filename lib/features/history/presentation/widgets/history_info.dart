import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/history/models/history_item.dart';

class HistoryInfo extends StatelessWidget {
  final HistoryItem item;

  const HistoryInfo({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      variant: ContainerVariant.basic,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      backgroundColor: context.colors.surfaceContainerLowest.withValues(alpha: 0.8),
      borderColor: context.colors.surfaceContainerLowest,
      child: Column(
        children: [
          _InfoRow(
            icon: HugeIcons.strokeRoundedStore01,
            label: 'Merchant',
            value: item.storeName,
          ),
          const DashedDivider(),
          _InfoRow(
            icon: HugeIcons.strokeRoundedLayers01,
            label: 'Category',
            value: item.category,
          ),
          const DashedDivider(),
          _InfoRow(
            icon: HugeIcons.strokeRoundedCalendar01,
            label: 'Date & Time',
            value: DateFormat('d MMMM yyyy, HH:mm').format(item.timestamp),
          ),
          const DashedDivider(),
          _InfoRow(
            icon: HugeIcons.strokeRoundedShoppingBag01,
            label: 'Total Items',
            value: '${item.totalItems} Products',
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final dynamic icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          HugeIcon(
            icon: icon,
            color: context.colors.outline,
            size: 20,
          ),
          AppSpacing.hGap12,
          Text(
            label,
            style: context.text.bodyMedium?.copyWith(
              color: context.colors.outline,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: context.text.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
