import 'package:flutter/material.dart';
import 'package:medical_profile_v3/utills/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenlayout;
  final Widget mobileScreenlayout;
  const ResponsiveLayout(
      {required this.mobileScreenlayout, required this.webScreenlayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return webScreenlayout;
      }
      return mobileScreenlayout;
    });
  }
}
