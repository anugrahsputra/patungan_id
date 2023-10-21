import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../injection.dart';
import '../../presentation.dart';

part 'auth_page.component.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final AppNavigator navigator = sl<AppNavigator>();

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    late String phoneNumber;

    final FirebaseAuth auth = FirebaseAuth.instance;

    Future<bool> isOtpVerified() async {
      var currentUser = auth.currentUser;

      if (currentUser != null) {
        await currentUser.reload();
        currentUser.getIdToken();
        currentUser = auth.currentUser; // Perbarui informasi pengguna

        return currentUser!.phoneNumber != null;
      }

      return false;
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            navigator.goToHome(context);
          },
          error: (message) {},
        );
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: PhoneField(
                    controller: phoneController,
                    ontap: () {
                      if (phoneController.text.isNotEmpty) {
                        String number = phoneController.text.trim();
                        phoneNumber = '+62$number';
                        cubit.signIn(phoneNumber: phoneNumber);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
