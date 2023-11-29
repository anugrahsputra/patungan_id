import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../injection.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    this.centerTitle = false,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.actions,
    this.title,
  });

  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final AppSettings appSettings = sl<AppSettings>();
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: appSettings.isDarkMode() ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: centerTitle,
        automaticallyImplyLeading: automaticallyImplyLeading,
        leading: leading,
        actions: actions,
        title: title,
      ),
    );
  }
}
