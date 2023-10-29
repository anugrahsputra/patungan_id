import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../injection.dart';
import '../../presentation.dart';

class SetupProfilePage extends StatelessWidget {
  SetupProfilePage({super.key});

  final AppNavigator navigator = sl<AppNavigator>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          success: () => navigator.goToHome(context),
          error: (_) {},
          otpResent: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: DefaultButton(
              onTap: () {
                context.read<AuthCubit>().saveToDatabase(name: 'your mom');
              },
              text: 'let go',
            ),
          ),
        );
      },
    );
  }
}
