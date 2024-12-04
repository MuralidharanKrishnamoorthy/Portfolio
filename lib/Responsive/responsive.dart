import 'package:flutter/material.dart';

class Responsivewidget extends StatelessWidget {
  const Responsivewidget(
      {super.key,
      required this.mobilebody,
      required this.desktopbody,
      required this.tabletbody});
  final Widget mobilebody;
  final Widget desktopbody;
  final Widget tabletbody;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return mobilebody;
      } else if (constraints.maxWidth < 1200) {
        return tabletbody;
      }
      return desktopbody;
    });
  }
}
