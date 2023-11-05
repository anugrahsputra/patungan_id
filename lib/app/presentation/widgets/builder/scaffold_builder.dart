import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/logic.dart';

class ScaffoldBuilder extends StatelessWidget {
  const ScaffoldBuilder({
    super.key,
    this.onThemeModeChange,
    this.appBar,
    this.backgroundColor,
    this.body,
    this.resizeToAvoidBottomInset,
    this.extendBodyBehindAppBar = false,
  });

  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget? body;
  final bool? resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;
  final Function(ThemeMode theme)? onThemeModeChange;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingCubit, SettingState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (themeMode) {
            if (onThemeModeChange != null) {
              onThemeModeChange!(themeMode);
            }
          },
        );
      },
      child: Scaffold(
        appBar: appBar,
        body: body,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
      ),
    );
  }
}
