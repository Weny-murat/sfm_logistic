import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CardWrapper extends StatelessWidget {
  final Widget child;
  final bool isExtended;
  const CardWrapper({this.isExtended = false, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isExtended ? 0 : 4,
        horizontal: 12,
      ),
      child: SizedBox(
        height: isExtended
            ? 12.h
            : Platform.isWindows
            ? 6.h
            : 8.h,
        width: double.maxFinite,
        child: child,
      ),
    );
  }
}

class DoubleCardWrapper extends StatelessWidget {
  final Widget child;
  const DoubleCardWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: SizedBox(height: 24.h, width: double.maxFinite, child: child),
    );
  }
}
