import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/themes/app_spacing.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/core/widgets/app_bottom_sheet.dart';
import 'package:smart_carbon_tracking/core/widgets/app_loading.dart';
import 'package:smart_carbon_tracking/core/widgets/header_app.dart';
import 'package:smart_carbon_tracking/core/widgets/scaffold_app.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/widgets/account_profile.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/widgets/setting_group.dart';
import 'package:smart_carbon_tracking/features/settings/presentation/widgets/setting_tile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String _selectedLanguage = 'English';
  String _selectedTheme = 'Light';
  bool _isNotificationEnabled = true;

  Future<void> _simulateProcess(
    String message,
    VoidCallback onComplete, {
    bool isSuccess = true,
  }) async {
    AppLoading.show(context, message: message);
    await Future.delayed(const Duration(milliseconds: 1500));

    if (mounted) {
      AppLoading.hide(context);

      if (isSuccess) {
        setState(onComplete);
      }
    }
  }

  void _showLanguage() async {
    final result = await AppBottomSheet.showSelection<String>(
      context,
      title: 'Select Language',
      selectedValue: _selectedLanguage,
      options: [
        const AppBottomSheetOption(
          label: 'English',
          icon: HugeIcons.strokeRoundedGlobe,
          value: 'English',
        ),
        const AppBottomSheetOption(
          label: 'Bahasa Indonesia',
          icon: HugeIcons.strokeRoundedGlobe,
          value: 'Bahasa Indonesia',
        ),
      ],
    );

    if (result != null && result != _selectedLanguage) {
      _simulateProcess('Updating language...', () {
        _selectedLanguage = result;
      });
    }
  }

  void _showThemeMode() async {
    final result = await AppBottomSheet.showSelection<String>(
      context,
      title: 'Select Theme Mode',
      selectedValue: _selectedTheme,
      options: [
        const AppBottomSheetOption(
          label: 'Light Mode',
          icon: HugeIcons.strokeRoundedSun01,
          value: 'Light',
        ),
        const AppBottomSheetOption(
          label: 'Dark Mode',
          icon: HugeIcons.strokeRoundedMoon02,
          value: 'Dark',
        ),
      ],
    );

    if (result != null && result != _selectedTheme) {
      _simulateProcess('Switching theme...', () {
        _selectedTheme = result;
      });
    }
  }

  void _showNotification() async {
    final result = await AppBottomSheet.showSelection<bool>(
      context,
      title: 'Notifications Settings',
      selectedValue: _isNotificationEnabled,
      options: [
        const AppBottomSheetOption(
          label: 'Enable Notifications',
          icon: HugeIcons.strokeRoundedNotification03,
          value: true,
        ),
        const AppBottomSheetOption(
          label: 'Disable Notifications',
          icon: HugeIcons.strokeRoundedNotificationOff01,
          value: false,
        ),
      ],
    );

    if (result != null && result != _isNotificationEnabled) {
      _simulateProcess(
        result ? 'Enabling notifications...' : 'Disabling notifications...',
        () {
          _isNotificationEnabled = result;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldApp(
      backgroundColor: context.colors.surfaceContainerLow,
      appBar: const HeaderApp(title: 'Settings'),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          overscroll: false,
          physics: const BouncingScrollPhysics(),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          children: [
            AccountProfile(
              name: 'Alexandria',
              email: 'alexandria@gmail.com',
              avatarUrl:
                  'https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=1000&auto=format&fit=crop',
              carbonSaved: '245.5 kg',
              ecoScore: '8.4',
              onTap: () {},
            ),
            AppSpacing.vGap24,

            SettingGroup(
              title: 'Personalization',
              backgroundColor: context.colors.primaryContainer,
              items: [
                SettingTile(
                  icon: HugeIcons.strokeRoundedGlobe,
                  title: 'Language',
                  iconColor: Colors.indigo,
                  value: _selectedLanguage,
                  valueColor: context.colors.primary,
                  onTap: _showLanguage,
                ),
                SettingTile(
                  icon: HugeIcons.strokeRoundedPaintBoard,
                  title: 'Theme Mode',
                  iconColor: Colors.amber,
                  value: _selectedTheme,
                  valueColor: context.colors.primary,
                  onTap: _showThemeMode,
                ),
                SettingTile(
                  icon: HugeIcons.strokeRoundedNotification03,
                  title: 'Notifications',
                  iconColor: Colors.green,
                  value: _isNotificationEnabled ? 'Enabled' : 'Disabled',
                  valueColor: context.colors.primary,
                  onTap: _showNotification,
                ),
              ],
            ),
            AppSpacing.vGap16,

            SettingGroup(
              title: 'Account & Security',
              backgroundColor: context.colors.secondaryContainer,
              items: [
                SettingTile(
                  icon: HugeIcons.strokeRoundedPasswordValidation,
                  title: 'Change Password',
                  iconColor: Colors.orange,
                ),
                SettingTile(
                  icon: HugeIcons.strokeRoundedShield01,
                  title: 'Privacy Settings',
                  iconColor: Colors.blue,
                ),
                SettingTile(
                  icon: HugeIcons.strokeRoundedLink01,
                  title: 'Social Accounts',
                  iconColor: Colors.cyan,
                ),
              ],
            ),
            AppSpacing.vGap16,

            SettingGroup(
              title: 'Support',
              backgroundColor: context.colors.tertiaryContainer,
              items: [
                SettingTile(
                  icon: HugeIcons.strokeRoundedInformationCircle,
                  title: 'About App',
                  iconColor: Colors.purple,
                ),
                SettingTile(
                  icon: HugeIcons.strokeRoundedHelpCircle,
                  title: 'Help Center',
                  iconColor: Colors.teal,
                ),
                SettingTile(
                  icon: HugeIcons.strokeRoundedBug01,
                  title: 'Report Bug',
                  iconColor: Colors.redAccent,
                ),
                SettingTile(
                  icon: HugeIcons.strokeRoundedSoftwareLicense,
                  title: 'App Version',
                  iconColor: Colors.blueGrey,
                  value: 'v1.0.0',
                  valueColor: context.colors.tertiary,
                ),
              ],
            ),
            AppSpacing.vGap16,

            SettingGroup(
              title: 'Session',
              backgroundColor: context.colors.errorContainer,
              items: [
                SettingTile(
                  icon: HugeIcons.strokeRoundedLogout03,
                  title: 'Sign Out',
                  iconColor: context.colors.error,
                  trailing: const SizedBox.shrink(),
                  onTap: () {},
                ),
              ],
            ),
            AppSpacing.vGap32,
          ],
        ),
      ),
    );
  }
}
