import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patungan_id/app/presentation/presentation.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../core/core.dart';
import '../../../injection.dart';

part 'verify_otp_page.component.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final AppNavigator navigator = sl<AppNavigator>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () => navigator.goToHome(context),
          otpResent: () {
            log('otp resent!');
          },
          error: (message) {
            log('otp salah');
          },
        );
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const PageTitle(),
                const SizedBox(height: 40),
                const InputCode(),
                const SizedBox(height: 40),
                ResendToken(
                  onPressed: () {
                    cubit.resendOtp(phoneNumber: widget.phoneNumber);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
