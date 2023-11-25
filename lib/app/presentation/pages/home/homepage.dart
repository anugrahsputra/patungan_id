import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logging/logging.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../../injection.dart';
import '../../presentation.dart';

part 'homepage.component.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final UserCubit userCubit = sl<UserCubit>();
  final AppNavigator navigator = sl<AppNavigator>();
  final SettingCubit settingCubit = sl<SettingCubit>();
  final ChangeThemeMode theme = sl<ChangeThemeMode>();
  final Logger log = Logger("homepage");

  getData() {
    context.read<UserCubit>().getCurrentUser();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (userEntity) => log.finest('user entity loaded'),
              redirect: () {
                log.severe(
                    'User is not exist in the database but manage to authenticate');
                log.warning('Proceeds to setup profile page');
                navigator.goToSetupProfile(context);
              },
              error: (message) {
                log.severe('Error: $message, go to not found page');
                navigator.notFound(context);
              },
            );
          },
        ),
        BlocListener<SettingCubit, SettingState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (themeMode) {},
            );
          },
        )
      ],
      child: ScaffoldBuilder(
        onThemeModeChange: (_) => setState(() {}),
        appBar: DefaultAppBar(
          title: const ProfileHeader(),
          actions: [
            IconButton(
              color: theme.isDarkMode() ? Colors.white : Colors.black,
              onPressed: () {
                context.read<SettingCubit>().changeThemeMode(
                      theme.isDarkMode() ? ThemeMode.light : ThemeMode.dark,
                    );
              },
              icon:
                  Icon(theme.isDarkMode() ? Icons.light_mode : Icons.dark_mode),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              const QuickMenu(),
              GroupCards(),
              SignOutBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
