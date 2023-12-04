import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../injection.dart';

class QuickMenuItem extends StatefulWidget {
  const QuickMenuItem({
    super.key,
    this.icon,
    required this.onTap,
  });

  final IconData? icon;
  final VoidCallback onTap;

  @override
  State<QuickMenuItem> createState() => _QuickMenuItemState();
}

class _QuickMenuItemState extends State<QuickMenuItem> {
  bool isTapped = false;
  final AppSettings theme = sl<AppSettings>();

  @override
  Widget build(BuildContext context) {
    final color = theme.isDarkMode()
        ? const Color(0xFFFFFFFF).withOpacity(1)
        : const Color(0xFF000000).withOpacity(1);
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (details) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (details) {
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            isTapped = false;
          });
        });
      },
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.isDarkMode() ? Colors.black : Colors.white,
          border: Border.all(
            color: color,
            width: 2,
          ),
          boxShadow: isTapped
              ? []
              : [
                  BoxShadow(
                    color: color,
                    offset: const Offset(4, 4),
                    blurRadius: 0,
                    spreadRadius: -1,
                  ),
                ],
        ),
        child: Icon(
          widget.icon,
          color: color,
        ),
      ),
    );
  }
}
