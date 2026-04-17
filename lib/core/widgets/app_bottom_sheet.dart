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
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    String? subtitle,
    required Widget child,
    Widget? headerAction,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AppBottomSheetWrapper(
        title: title,
        subtitle: subtitle,
        headerAction: headerAction,
        child: child,
      ),
    );
  }

  static Future<T?> showSelection<T>(
    BuildContext context, {
    required String title,
    String? subtitle,
    required List<AppBottomSheetOption> options,
    required T selectedValue,
  }) {
    return show<T>(
      context,
      title: title,
      subtitle: subtitle,
      child: _SelectionList<T>(options: options, selectedValue: selectedValue),
    );
  }

  static Future<bool?> showConfirmation(
    BuildContext context, {
    required String title,
    String? subtitle,
    String confirmLabel = 'Konfirmasi',
    String cancelLabel = 'Batal',
    bool isDanger = false,
  }) {
    return show<bool>(
      context,
      title: title,
      subtitle: subtitle,
      child: _ConfirmationContent(
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDanger: isDanger,
      ),
    );
  }
}

class AppBottomSheetWrapper extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? headerAction;
  final Widget child;

  const AppBottomSheetWrapper({
    super.key,
    required this.title,
    this.subtitle,
    this.headerAction,
    required this.child,
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
      padding: EdgeInsets.fromLTRB(
        24,
        12,
        24,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 5,
            decoration: BoxDecoration(
              color: context.colors.outlineVariant.withValues(alpha: .4),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          AppSpacing.vGap24,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: context.text.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: context.colors.onSurface,
                  ),
                ),
              ),
              if (headerAction != null) headerAction!,
            ],
          ),
          if (subtitle != null) ...[
            AppSpacing.vGap4,
            Text(
              subtitle!,
              style: context.text.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant.withValues(alpha: .7),
                height: 1.3,
              ),
            ),
          ],
          AppSpacing.vGap24,

          Flexible(child: child),
        ],
      ),
    );
  }
}

class _SelectionList<T> extends StatelessWidget {
  final List<AppBottomSheetOption> options;
  final T selectedValue;

  const _SelectionList({required this.options, required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
                color: isSelected
                    ? context.colors.primary
                    : context.colors.onSurface,
              ),
            ),
            trailing: isSelected
                ? Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: context.colors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: context.colors.surface,
                      size: 14,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }
}

class _ConfirmationContent extends StatelessWidget {
  final String confirmLabel;
  final String cancelLabel;
  final bool isDanger;

  const _ConfirmationContent({
    required this.confirmLabel,
    required this.cancelLabel,
    required this.isDanger,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        // ─── Cancel Button ───
        Expanded(
          flex: 1,
          child: TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: context.colors.outlineVariant,
                  width: 1,
                ),
              ),
            ),
            child: Text(
              cancelLabel,
              style: context.text.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ),
        ),

        // ─── Confirm Button ───
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: isDanger ? Colors.red.shade400 : context.colors.primary,
              foregroundColor: context.colors.onPrimary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              confirmLabel,
              style: context.text.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
