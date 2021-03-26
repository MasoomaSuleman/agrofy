import 'package:flutter/material.dart';

class ColoredTabBar extends Container implements PreferredSize {
  ColoredTabBar(this.color, this.tabBar);
  final Color color;
  final TabBar tabBar;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => tabBar.preferredSize;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50.0,
      color: color,
      child: tabBar,
    );
  }
}
