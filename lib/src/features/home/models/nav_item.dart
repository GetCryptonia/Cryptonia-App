import 'package:flutter/cupertino.dart';

class NavItem {
  String label;
  String activeIcon;
  String passiveIcon;
  Widget page;

  NavItem({
    required this.label,
    required this.activeIcon,
    required this.passiveIcon,
    required this.page,
  });
}
