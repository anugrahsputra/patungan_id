import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.when(
            initial: () {},
            loading: () {},
            success: () {
              navigator.goToVerify(context, phoneNumber: phoneNumber);
              AuthCubit.get(context).getCurrentUser();
            },
            error: (message) {
              log(message);
            },
            otpResent: () {});
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 80,
                ),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.6,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 25,
                  ),
                  child: Column(
                    children: [
                      const Header(),
                      const Spacer(),
                      PhoneField(
                        controller: phoneController,
                        ontap: () {
                          if (phoneController.text.isNotEmpty) {
                            String number = phoneController.text.trim();
                            phoneNumber = '+62$number';
                            cubit.signIn(phoneNumber: phoneNumber);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
