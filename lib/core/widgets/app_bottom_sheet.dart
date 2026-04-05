import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/dashed_divider.dart';

class AppBottomSheetOption {
  final String label;
  final dynamic icon;
  final dynamic value;

  const AppBottomSheetOption({
    required this.label,
    required this.icon,
    required this.value,
  });
}

class AppBottomSheet {
  static Future<T?> showSelection<T>(
    BuildContext context, {
    required String title,
    required List<AppBottomSheetOption> options,
    required T selectedValue,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _BottomSheetWidget<T>(
        title: title,
        options: options,
        selectedValue: selectedValue,
      ),
    );
  }
}

class _BottomSheetWidget<T> extends StatelessWidget {
  final String title;
  final List<AppBottomSheetOption> options;
  final T selectedValue;

  const _BottomSheetWidget({
    required this.title,
    required this.options,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 48,
            height: 5,
            decoration: BoxDecoration(
              color: context.colors.outlineVariant.withValues(alpha: .4),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          AppSpacing.vGap24,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: context.text.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: context.colors.onSurface,
              ),
            ),
          ),
          AppSpacing.vGap24,
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: options.length,
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: DashedDivider(),
              ),
              itemBuilder: (context, index) {
                final option = options[index];
                final isSelected = option.value == selectedValue;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    onTap: () => Navigator.pop(context, option.value),
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? context.colors.primaryContainer.withValues(alpha: .4)
                            : context.colors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: HugeIcon(
                        icon: option.icon,
                        color: isSelected ? context.colors.primary : Colors.grey,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      option.label,
                      style: context.text.bodyLarge?.copyWith(
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? context.colors.primary : context.colors.onSurface,
                      ),
                    ),
                    trailing: isSelected
                        ? Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: context.colors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            ),
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
          AppSpacing.vGap16,
        ],
      ),
    );
  }
}
