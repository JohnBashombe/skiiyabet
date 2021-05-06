import 'package:flutter/material.dart';

class ResponsiveWidget {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isBigScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 992;
  }

  static bool isExtraSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 340;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static bool isExtraLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 767.98 &&
        MediaQuery.of(context).size.width < 991.98;
  }

  static bool customScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 992 &&
        MediaQuery.of(context).size.width < 1024;
  }
}
