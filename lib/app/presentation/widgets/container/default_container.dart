import 'package:flutter/material.dart';

import '../../../core/core.dart';

class DefaultContainer extends StatelessWidget {
  const DefaultContainer({
    super.key,
    this.alignment,
    this.width,
    this.height,
    this.child,
    this.padding,
    this.margin,
    required this.appSettings,
  });

  final Alignment? alignment;
  final double? width, height;
  final AppSettings appSettings;
  final Widget? child;
  final EdgeInsetsGeometry? padding, margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: appSettings.isDarkMode()
            ? const Color(0xFF000000).withOpacity(1)
            : const Color(0xFFFFFFFF).withOpacity(1),
        border: Border.all(
          width: 2,
          color: appSettings.isDarkMode()
              ? const Color(0xFFFFFFFF).withOpacity(1)
              : const Color(0xFF000000).withOpacity(1),
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: appSettings.isDarkMode()
                ? const Color(0xFFFFFFFF).withOpacity(1)
                : const Color(0xFF000000).withOpacity(1),
            offset: const Offset(4, 4),
            blurRadius: 0,
            spreadRadius: -1,
          ),
        ],
      ),
      child: child,
    );
  }
}
