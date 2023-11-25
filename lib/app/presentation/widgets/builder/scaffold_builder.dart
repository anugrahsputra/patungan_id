import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        backgroundColor: widget.backgroundColor,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      ),
    );
  }
}
