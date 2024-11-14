import 'package:flutter/material.dart';

class PageNavigation {
  static void pushPage(BuildContext context, Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));

  static void replacePage(BuildContext context, Widget page) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => page));

  static void popPage(BuildContext context, [int times = 1]) {
    int count = 0;

    Navigator.popUntil(context, (route) {
      return count++ == times;
    });
  }

  //pass data while popping page
  static void pop(BuildContext context, dynamic data) {
    Navigator.pop(context, data);
  }

  static void replaceAll(BuildContext context, Widget page) =>
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => page), (route) => false);
}
