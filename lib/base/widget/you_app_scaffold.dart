import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../app_theme.dart';

class YouAppScaffold extends Scaffold {
  const YouAppScaffold({
    super.key,
    super.appBar,
    super.body,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.floatingActionButtonAnimator,
    super.persistentFooterButtons,
    super.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    super.drawer,
    super.onDrawerChanged,
    super.endDrawer,
    super.onEndDrawerChanged,
    super.bottomNavigationBar,
    super.bottomSheet,
    super.backgroundColor,
    super.resizeToAvoidBottomInset,
    super.primary = true,
    super.drawerDragStartBehavior = DragStartBehavior.start,
    super.extendBody = false,
    super.extendBodyBehindAppBar = false,
    super.drawerScrimColor,
    super.drawerEdgeDragWidth,
    super.drawerEnableOpenDragGesture = true,
    super.endDrawerEnableOpenDragGesture = true,
    super.restorationId,
  });

  @override
  ScaffoldState createState() => _YouAppScaffoldState();
}

class _YouAppScaffoldState extends ScaffoldState {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            colorGradient1,
            colorGradient2,
            colorGradient3,
          ],
          stops: [
            0.0,
            0.56,
            1.00,
          ],
          center: Alignment(.8, -0.8),
          radius: 3,
        ),
      ),
      child: Builder(builder: super.build),
    );
  }
}
