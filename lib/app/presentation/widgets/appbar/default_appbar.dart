import 'package:flutter/material.dart';

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
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Colors.transparent,
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
