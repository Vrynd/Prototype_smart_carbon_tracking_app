import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/widgets/app_bottom_bar.dart';

class BarAction extends StatelessWidget {
  final String safetyTitle;
  final String safetySubtitle;
  final String buttonLabel;
  final bool isConfirmed;
  final ValueChanged<bool> onConfirmedChanged;
  final VoidCallback? onPressed;

  const BarAction({
    super.key,
    required this.safetyTitle,
    required this.safetySubtitle,
    required this.buttonLabel,
    required this.isConfirmed,
    required this.onConfirmedChanged,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBottomBar(
      safetyTitle: safetyTitle,
      safetySubtitle: safetySubtitle,
      buttonLabel: buttonLabel,
      isConfirmed: isConfirmed,
      onConfirmedChanged: onConfirmedChanged,
      onActionPressed: onPressed,
    );
  }
}
