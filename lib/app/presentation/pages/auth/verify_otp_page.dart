import 'dart:async';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String otpCode = '';

  final AppNavigator navigator = sl<AppNavigator>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            navigator.goToHome(context);
          },
          otpResent: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("OTP has been resent"),
              ),
            );
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Kesalahan otentikasi: $message"),
              ),
            );
          },
        );
      },
      builder: (context, state) {
        return ScaffoldBuilder(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          onThemeModeChange: (_) => setState(() {}),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.4,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 96,
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 80, 10, 0),
                  child: Column(
                    children: [
                      PageTitle(phoneNumber: widget.phoneNumber),
                      const SizedBox(height: 80),
                      OTPTextField(
                        onCompleted: (value) {
                          if (value.length == 6) {
                            otpCode = value.trim();
                            log(otpCode);
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      SubmitOtp(
                        onPressed: () {
                          log(otpCode);
                          context.read<AuthCubit>().verifyOtp(otp: otpCode);
                        },
                      ),
                      const Spacer(),
                      ResendOtp(
                        onPressed: () {
                          context
                              .read<AuthCubit>()
                              .resendOtp(phoneNumber: widget.phoneNumber);
                        },
                      )
                    ],
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
