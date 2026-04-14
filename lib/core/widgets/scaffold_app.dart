import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';
import 'header_app.dart';

class ScaffoldApp extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final bool isFullScreen;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const ScaffoldApp({
    super.key,
    this.appBar,
    required this.body,
    this.isFullScreen = false,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  State<ScaffoldApp> createState() => _ScaffoldAppState();
}

class _ScaffoldAppState extends State<ScaffoldApp> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _sytemUIOverlay();
  }

  @override
  void didUpdateWidget(covariant ScaffoldApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFullScreen != oldWidget.isFullScreen ||
        widget.backgroundColor != oldWidget.backgroundColor) {
      _sytemUIOverlay();
    }
  }

  void _sytemUIOverlay() {
    if (widget.isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = widget.appBar;
    PreferredSizeWidget? effectiveAppBar = appBar;

    // Inject isScrolled state if the appBar is a HeaderApp
    if (appBar is HeaderApp) {
      effectiveAppBar = HeaderApp(
        title: appBar.title,
        leading: appBar.leading,
        actions: appBar.actions,
        centerTitle: appBar.centerTitle,
        toolbarHeight: appBar.toolbarHeight,
        backgroundColor: appBar.backgroundColor,
        variant: appBar.variant,
        isScrolled: _isScrolled,
      );
    }

    return Scaffold(
      backgroundColor: widget.backgroundColor ?? context.colors.surfaceContainerLow,
      appBar: effectiveAppBar,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            final bool scrolled = notification.metrics.pixels > 10;
            if (scrolled != _isScrolled) {
              setState(() {
                _isScrolled = scrolled;
              });
            }
          }
          return false;
        },
        child: widget.body,
      ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}