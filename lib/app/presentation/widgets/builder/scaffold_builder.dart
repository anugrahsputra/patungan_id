import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../injection.dart';
import '../../logic/logic.dart';

class ScaffoldBuilder extends StatefulWidget {
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
  State<ScaffoldBuilder> createState() => _ScaffoldBuilderState();
}

class _ScaffoldBuilderState extends State<ScaffoldBuilder> {
  final AppSettings appSettings = sl<AppSettings>();

  getThemeMode() {
    context.read<SettingCubit>().fetchSetting();
  }

  @override
  void initState() {
    super.initState();
    getThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    final color = appSettings.isDarkMode() ? Colors.black : Colors.white;
    return BlocListener<SettingCubit, SettingState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (themeMode) {
            if (widget.onThemeModeChange != null) {
              widget.onThemeModeChange!(themeMode);
            }
          },
        );
      },
      child: Scaffold(
        appBar: widget.appBar,
        body: widget.body,
        backgroundColor: widget.backgroundColor ?? color,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      ),
    );
  }
}
