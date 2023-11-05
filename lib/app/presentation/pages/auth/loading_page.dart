import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../injection.dart';
import '../../presentation.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final AppNavigator navigator = sl<AppNavigator>();

  getData() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<UserCubit>().getCurrentUser();
      }
    });
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
          loaded: (userEntity) {
            navigator.goToHome(context);
          },
          redirect: () => navigator.goToSetupProfile(context),
        );
      },
      child: ScaffoldBuilder(
        onThemeModeChange: (theme) => setState(() {}),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
