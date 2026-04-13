import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/app_container.dart';
import 'package:smart_carbon_tracking/core/widgets/dashed_divider.dart';

class AccountProfile extends StatelessWidget {
  final String name;
  final String email;
  final String avatarUrl;
  final String carbonSaved;
  final String ecoScore;
  final VoidCallback? onTap;

  const AccountProfile({
    super.key,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.carbonSaved,
    required this.ecoScore,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AppContainer.compact(
        children: [
          Row(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: Image.network(avatarUrl).image,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      name,
                      style: context.text.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colors.onSurface,
                      ),
                    ),
                    Text(
                      email,
                      style: context.text.bodyLarge?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                color: context.colors.onSurfaceVariant,
                size: 24,
              ),
            ],
          ),
          const DashedDivider(indent: 72),
          Padding(
            padding: const EdgeInsets.only(left: 72),
            child: Row(
              children: [
                _buildStatItem(
                  context,
                  label: 'Carbon Saved',
                  value: carbonSaved,
                ),
                _buildStatItem(context, label: 'Eco Score', value: ecoScore),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.text.labelMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: context.text.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: context.colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
