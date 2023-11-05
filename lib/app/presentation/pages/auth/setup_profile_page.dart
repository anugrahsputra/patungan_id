import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../injection.dart';
import '../../presentation.dart';

class SetupProfilePage extends StatefulWidget {
  const SetupProfilePage({super.key});

  @override
  State<SetupProfilePage> createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {
  final AppNavigator navigator = sl<AppNavigator>();

  saveData(String name, String photoUrl) {
    context.read<AuthCubit>().saveToDatabase(name: name, photoUrl: photoUrl);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () => navigator.goToHome(context),
          error: (_) {},
          otpResent: () {},
        );
      },
      builder: (context, state) {
        return ScaffoldBuilder(
          onThemeModeChange: (_) => setState(() {}),
          body: Center(
            child: DefaultButton(
              onTap: () async {
                final url =
                    await context.read<AuthCubit>().getDefaultProfilePic();
                saveData('your mom', url);
              },
              text: 'let go',
            ),
          ),
        );
      },
    );
  }
}
