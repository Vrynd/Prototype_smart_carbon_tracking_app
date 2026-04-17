import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/core.dart';

class GreenTips extends StatelessWidget {
  final List<String> tips;

  const GreenTips({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      variant: ContainerVariant.basic,
      padding: EdgeInsets.zero,
      backgroundColor: context.colors.surfaceContainerLowest.withValues(
        alpha: 0.8,
      ),
      borderColor: context.colors.surfaceContainerLowest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Green Living Tips',
              style: context.text.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colors.onSurface,
              ),
            ),
          ),
          const DashedDivider(),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            itemCount: tips.length,
            separatorBuilder: (context, index) => AppSpacing.vGap8,
            itemBuilder: (context, index) {
              return _TipItem(
                index: index + 1,
                tip: tips[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final int index;
  final String tip;

  const _TipItem({required this.index, required this.tip});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      dense: true,
      horizontalTitleGap: 12,
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFF10B981).withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            index.toString().padLeft(2, '0'),
            style: context.text.labelMedium?.copyWith(
              color: const Color(0xFF10B981),
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ),
      title: Text(
        tip,
        style: context.text.bodyMedium?.copyWith(
          color: context.colors.onSurface.withValues(alpha: 0.8),
          height: 1.4,
        ),
      ),
    );
  }
}
