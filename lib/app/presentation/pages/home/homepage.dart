import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final SettingCubit settingCubit = sl<SettingCubit>();

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
    return ScaffoldBuilder(
      onThemeModeChange: (_) => setState(() {}),
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return state.when(
                  initial: () {
                    return const SizedBox();
                  },
                  loading: () {
                    return const SizedBox();
                  },
                  loaded: (userEntity) {
                    UserEntity? user = userEntity;
                    return Center(
                      child: Text(user?.name ?? ''),
                    );
                  },
                  error: (message) {
                    return Text(message);
                  },
                  redirect: () => const Text('Something is wrong'));
            },
          ),
          SignOutBtn(),
        ],
      ),
    );
  }
}
