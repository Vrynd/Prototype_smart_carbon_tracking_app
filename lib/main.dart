import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_carbon_tracking/core/router/app_router.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'package:smart_carbon_tracking/features/navigation/controllers/bottom_bar_controller.dart';
import 'package:smart_carbon_tracking/features/scan/controllers/scan_controller.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BottomBarController()),
      ChangeNotifierProvider(create: (_) => ScanController()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Smart Carbon Tracking',
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
