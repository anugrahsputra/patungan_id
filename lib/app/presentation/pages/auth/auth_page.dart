import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/core.dart';
import '../../../injection.dart';
import '../../presentation.dart';

part 'auth_page.component.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AppNavigator navigator = sl<AppNavigator>();

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    final AppSettings themeMode = sl<AppSettings>();
    late String phoneNumber;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          otpSent: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("OTP has been sent"),
              ),
            );
            navigator.goToVerify(context, phoneNumber: phoneNumber);
          },
          error: (message) {
            log(message);
          },
        );
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return ScaffoldBuilder(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                color: themeMode.isDarkMode() ? Colors.white : Colors.black,
                onPressed: () {
                  context.read<SettingCubit>().changeThemeMode(
                        themeMode.isDarkMode()
                            ? ThemeMode.light
                            : ThemeMode.dark,
                      );
                },
                icon: Icon(themeMode.isDarkMode()
                    ? Icons.light_mode
                    : Icons.dark_mode),
              ),
            ],
          ),
          onThemeModeChange: (_) => setState(() {}),
          extendBodyBehindAppBar: true,
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
                      Header(
                        logo: themeMode.isDarkMode()
                            ? LogoPath.logoDark
                            : LogoPath.logoLight,
                      ),
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
