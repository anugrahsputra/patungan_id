part of 'verify_otp_page.dart';

class PageTitle extends StatelessWidget {
  PageTitle({super.key, required this.phoneNumber});
  final AppSettings theme = sl<AppSettings>();

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.verifyOtp,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 48,
            fontWeight: FontWeight.w600,
            color: theme.isDarkMode() ? Colors.white : Colors.black,
          ),
        ),
        const Gap(17),
        Text(
          '${AppString.verifyOtpSubtitle}$phoneNumber',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class InputCode extends StatefulWidget {
  const InputCode({super.key});

  @override
  State<InputCode> createState() => _InputCodeState();
}

class _InputCodeState extends State<InputCode> {
  final AppSettings themeMode = sl<AppSettings>();

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }

  @override
  void initState() {
    super.initState();
    _listenSmsCode();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: themeMode.isDarkMode() ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF000000).withOpacity(1),
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(1),
            offset: const Offset(6, 6),
            blurRadius: 0,
            spreadRadius: -1,
          ),
        ],
      ),
      child: OTPTextField(
        onCompleted: (value) {
          if (value.length == 6) {
            cubit.verifyOtp(otp: value.trim());
          }
        },
      ),
    );
  }
}

class ResendOtp extends StatefulWidget {
  const ResendOtp({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<ResendOtp> createState() => _ResendOtpState();
}

class _ResendOtpState extends State<ResendOtp> {
  final ValueNotifier<int> _time = ValueNotifier<int>(60);

  final AppSettings theme = sl<AppSettings>();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_time.value > 0) {
        _time.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _time,
      builder: (context, value, child) {
        if (value == 0) {
          return RichText(
              text: TextSpan(
                  text: AppString.codeQuestion,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                  children: [
                TextSpan(
                  text: ' No!',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.isDarkMode() ? Colors.white : Colors.black,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = widget.onPressed,
                )
              ]));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class SubmitOtp extends StatefulWidget {
  const SubmitOtp({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<SubmitOtp> createState() => _SubmitOtpState();
}

class _SubmitOtpState extends State<SubmitOtp> {
  final ValueNotifier<int> _time = ValueNotifier<int>(60);

  final AppSettings theme = sl<AppSettings>();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_time.value > 0) {
        _time.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 125,
          child: DefaultButton(
            onTap: widget.onPressed,
            text: AppString.go,
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 125,
          child: ValueListenableBuilder<int>(
            valueListenable: _time,
            builder: (context, value, child) {
              if (value == 0) {
                return Text(
                  AppString.otpExp,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                );
              } else {
                return Text(
                  value.toString().padLeft(2, '0'),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
