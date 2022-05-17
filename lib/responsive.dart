import 'package:flutter/material.dart';

import 'screens/config/size_config.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) => SizeConfig.screenwidth < 850;

  static bool isTablet(BuildContext context) =>
      SizeConfig.screenwidth < 1100 && SizeConfig.screenwidth >= 850;

  static bool isDesktop(BuildContext context) => SizeConfig.screenwidth >= 1100;

  @override
  Widget build(BuildContext context) {
    // If our width is more than 1100 then we consider it a desktop
    if (SizeConfig.screenwidth >= 1100) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (SizeConfig.screenwidth >= 850 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}
