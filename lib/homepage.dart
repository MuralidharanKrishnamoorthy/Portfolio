import 'package:flutter/material.dart';
import 'package:portfolio_app/Responsive/Responsive.dart';
import 'package:portfolio_app/Responsive/desktopbody.dart';
import 'package:portfolio_app/Responsive/mobilebody.dart';
import 'package:portfolio_app/Responsive/tabletbody.dart';

class Portfoliohome extends StatefulWidget {
  const Portfoliohome({super.key});

  @override
  State<Portfoliohome> createState() => _PortfoliohomeState();
}

class _PortfoliohomeState extends State<Portfoliohome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsivewidget(
          mobilebody: Mobilebody(),
          tabletbody: Tabletbody(),
          desktopbody: Desktopbody()),
    );
  }
}
