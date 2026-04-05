import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

class AppLoading {
  static void show(BuildContext context, {String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: .5),
      builder: (context) => PopScope(
        canPop: false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 48),
              decoration: BoxDecoration(
                color: context.colors.surface.withValues(alpha: .8),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: context.colors.outlineVariant.withValues(alpha: .3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .15),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 56,
                        height: 56,
                        child: CircularProgressIndicator(
                          color: context.colors.primary,
                          strokeWidth: 3.5,
                          backgroundColor: context.colors.primaryContainer.withValues(alpha: .5),
                        ),
                      ),
                      Icon(
                        Icons.hourglass_empty_rounded,
                        color: context.colors.primary,
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.text.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
