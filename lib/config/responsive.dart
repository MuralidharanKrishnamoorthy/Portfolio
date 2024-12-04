import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  // Width factors
  double get smallPadding => screenWidth * 0.01; // 2% of screen width
  double get mediumPadding => screenWidth * 0.04; // 4% of screen width
  double get largePadding => screenWidth * 0.06;
  double get largeultrapadding => screenWidth * 0.19;

  double get leftPadding => screenWidth * 0.03; // 3% for left
  double get rightPadding => screenWidth * 0.3; // 3% for right
  double get smallrightpadding => screenWidth * 0.8;
  double get topPadding => screenHeight * 0.02; // 2% of screen height
  double get smalltopPadding => screenHeight * 0.05;
  double get bottomPadding => screenHeight * 0.02; // 2% of screen height

  // Height factors
  double get smallSpacing => screenHeight * 0.01; // 1% of screen height
  double get mediumSpacing => screenHeight * 0.03; // 3% of screen height
  double get largeSpacing => screenHeight * 0.05; // 5% of screen height

  // Widget-specific sizes
  double get buttonHeight => screenHeight * 0.07; // 7% of screen height
  double get buttonWidth => screenWidth * 0.5; // 50% of screen width

  double get textFontSmall => screenWidth * 0.03; // 3% of screen width
  double get textsemismall => screenWidth * 0.04;
  double get textFontMedium => screenWidth * 0.06; // 5% of screen width
  double get textFontLarge => screenWidth * 0.07; // 7% of screen width

  double get containerHeight => screenHeight * 0.3; // 20% of screen height
  double get containerWidth => screenWidth * 0.8; // 80% of screen width

  double get smallprofile => screenWidth * 0.15;
  double get semismallprofile => screenWidth * 0.06;
  double get largeprofile => screenWidth * 0.25;
}
