import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_carbon_tracking/core/core.dart';
import 'package:smart_carbon_tracking/features/settings/settings.dart';

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

            AppSettingGroup(
              title: 'Personalization',
              variant: GroupVariant.modern,
              backgroundColor: context.colors.primaryContainer,
              children: [
                AppSettingTile(
                  icon: HugeIcons.strokeRoundedGlobe,
                  title: 'Language',
                  variant: TileVariant.modern,
                  iconColor: Colors.indigo,
                  value: _selectedLanguage,
                  valueColor: context.colors.primary,
                  onTap: _showLanguage,
                ),
                AppSettingTile(
                  icon: HugeIcons.strokeRoundedPaintBoard,
                  title: 'Theme Mode',
                  variant: TileVariant.modern,
                  iconColor: Colors.amber,
                  value: _selectedTheme,
                  valueColor: context.colors.primary,
                  onTap: _showThemeMode,
                ),
                AppSettingTile(
                  icon: HugeIcons.strokeRoundedNotification03,
                  title: 'Notifications',
                  variant: TileVariant.modern,
                  iconColor: Colors.green,
                  value: _isNotificationEnabled ? 'Enabled' : 'Disabled',
                  valueColor: context.colors.primary,
                  onTap: _showNotification,
                ),
              ],
            ),
            AppSpacing.vGap16,

            AppSettingGroup(
              title: 'Account & Security',
              variant: GroupVariant.modern,
              backgroundColor: context.colors.secondaryContainer,
              children: [
                AppSettingTile(
                  icon: HugeIcons.strokeRoundedPasswordValidation,
                  title: 'Change Password',
                  variant: TileVariant.modern,
                  iconColor: Colors.orange,
                  onTap: () {
                    context.push('/settings/change-password');
                  },
                ),
                AppSettingTile(
                  icon: HugeIcons.strokeRoundedShield01,
                  title: 'Privacy Settings',
                  variant: TileVariant.modern,
                  iconColor: Colors.blue,
                  onTap: () {
                    context.push('/settings/privacy');
                  },
                ),
              ],
            ),
            AppSpacing.vGap16,

            AppSettingGroup(
              title: 'Support',
              variant: GroupVariant.modern,
              backgroundColor: context.colors.tertiaryContainer,
              children: [
                AppSettingTile(
                  icon: HugeIcons.strokeRoundedInformationCircle,
                  title: 'About App',
                  variant: TileVariant.modern,
                  iconColor: Colors.purple,
                ),
                AppSettingTile(
                  icon: HugeIcons.strokeRoundedHelpCircle,
                  title: 'Help Center',
                  variant: TileVariant.modern,
                  iconColor: Colors.teal,
                ),
                AppSettingTile(
                  icon: HugeIcons.strokeRoundedBug01,
                  title: 'Report Bug',
                  variant: TileVariant.modern,
                  iconColor: Colors.redAccent,
                ),
                AppSettingTile(
                  icon: HugeIcons.strokeRoundedSoftwareLicense,
                  title: 'App Version',
                  variant: TileVariant.modern,
                  iconColor: Colors.blueGrey,
                  value: 'v1.0.0',
                  valueColor: context.colors.tertiary,
                ),
              ],
            ),
            AppSpacing.vGap16,

            AppSettingGroup(
              title: 'Session',
              variant: GroupVariant.modern,
              backgroundColor: context.colors.errorContainer,
              children: [
                AppSettingTile(
                  icon: HugeIcons.strokeRoundedLogout03,
                  title: 'Sign Out',
                  variant: TileVariant.modern,
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
