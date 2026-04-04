import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/section_header.dart';

class DailyTips extends StatelessWidget {
  final String title;
  final String description;
  final dynamic icon;
  final String impact; // Tambahan untuk Est. Impact
  final VoidCallback? onTap;

  const DailyTips({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.impact,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Daily Tips',
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              // Kartu Utama Berbentuk Daun (Eco-Sculpted)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      context.colors.surfaceContainer,
                      context.colors.primary.withValues(alpha: 0.12),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(56),
                    bottomRight: Radius.circular(56),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  border: Border.all(
                    color: context.colors.primary.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(56),
                    bottomRight: Radius.circular(56),
                  ),
                  child: Stack(
                    children: [
                      // Tekstur Pola Latar Belakang
                      Positioned(
                        right: -10,
                        top: 20,
                        child: Opacity(
                          opacity: 0.08,
                          child: HugeIcon(
                            icon: icon,
                            color: context.colors.primary,
                            size: 150,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 40,
                        bottom: -30,
                        child: Opacity(
                          opacity: 0.06,
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedLeaf01,
                            color: context.colors.primary,
                            size: 100,
                          ),
                        ),
                      ),
                      
                      // Konten Naratif
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badge "DAILY ECO-TIP"
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: context.colors.primary,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: context.colors.primary.withValues(alpha: 0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                'DAILY ECO-TIP',
                                style: context.text.labelSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              title,
                              style: context.text.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: context.colors.onSurface,
                                fontSize: 24,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              description,
                              style: context.text.bodyMedium?.copyWith(
                                color: context.colors.onSurfaceVariant,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            // Info Impact & Button Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Impact Tag
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      HugeIcon(
                                        icon: HugeIcons.strokeRoundedLeaf02,
                                        color: context.colors.primary,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Impact: $impact',
                                        style: context.text.labelLarge?.copyWith(
                                          color: context.colors.primary,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Pill Button
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: context.colors.primary.withValues(alpha: 0.2),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: HugeIcon(
                                    icon: HugeIcons.strokeRoundedArrowRight01,
                                    color: context.colors.primary,
                                    size: 20,
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
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
