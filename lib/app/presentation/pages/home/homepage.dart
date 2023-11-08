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
  final ChangeThemeMode themeMode = sl<ChangeThemeMode>();
  final Logger log = Logger("homepage");
  UserEntity? user;

  getData() {
    context.read<UserCubit>().getCurrentUser();
    user = context.read<UserCubit>().userEntity;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
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
      child: ScaffoldBuilder(
        appBar: DefaultAppBar(
          title: ProfileHeader(user: user),
          actions: [
            ActionIcons(icon: Icons.search),
            const Gap(10),
            ActionIcons(icon: Icons.notifications_none_rounded),
            const Gap(10),
          ],
        ),
        onThemeModeChange: (theme) => setState(() {}),
        extendBodyBehindAppBar: true,
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => Loading(),
              loaded: (userEntity) {
                UserEntity? user = userEntity;
                return ContentView(user: user);
              },
              redirect: () => Loading(),
              error: (_) => Loading(),
              orElse: () => Loading(),
            );
          },
        ),
      ),
    );
  }
}
