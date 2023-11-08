import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../injection.dart';

class ActionIcons extends StatelessWidget {
  ActionIcons({
    super.key,
    this.icon,
    this.onTap,
  });

  final IconData? icon;
  final Function()? onTap;
  final ChangeThemeMode themeMode = sl<ChangeThemeMode>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
            )),
        child: Icon(
          icon,
          color: themeMode.isDarkMode() ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
