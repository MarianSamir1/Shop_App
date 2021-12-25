import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shop_app/layout/layout_screen.dart';

import '../menu_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        style: DrawerStyle.Style1,
        showShadow: true,
        borderRadius: 30,
        angle: -8,
        mainScreen: const LayoutScreen() ,
        menuScreen: const MenuScreen(),
    );
  }
}