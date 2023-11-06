import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        state.whenOrNull(
          redirect: () {
            log.severe(
                'User is not exist in the database but manage to authenticate');
            log.warning('Proceeds to setup profile page');
            navigator.goToSetupProfile(context);
          },
        );
      },
      child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        return state.when(
          initial: () {
            return const SizedBox();
          },
          loading: () => const SizedBox(),
          loaded: (userEntity) {
            UserEntity? user = userEntity;
            return ScaffoldBuilder(
              onThemeModeChange: (theme) => setState(() {}),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text(user?.name ?? '')),
                  SignOutBtn(),
                ],
              ),
            );
          },
          redirect: () {
            return const Center();
          },
          error: (_) {
            return const SizedBox();
          },
        );
      }),
    );
  }
}
