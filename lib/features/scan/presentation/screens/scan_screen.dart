import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/widgets/scaffold_app.dart';
import 'package:smart_carbon_tracking/features/scan/presentation/widgets/preview_camera.dart';
import 'package:smart_carbon_tracking/features/scan/presentation/widgets/action_dock.dart';
import 'package:smart_carbon_tracking/features/scan/presentation/widgets/toolbar.dart';
import 'package:smart_carbon_tracking/features/scan/presentation/widgets/scanner_overlay.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldApp(
      body: Stack(
        children: [
          const PreviewCamera(title: 'Align receipt within the frame'),
          const ScannerOverlay(),
          
          Toolbar(
            onBackTap: () => Navigator.pop(context),
            onFlashTap: () {},
            bannerTitle: 'Scan receipt to get points',
          ),
        
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ActionDock(),
          ),
        ],
      ),
    );
  }
}
