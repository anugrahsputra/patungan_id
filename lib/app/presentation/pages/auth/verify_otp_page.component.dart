part of 'verify_otp_page.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
      child: Text(
        'Enter OTP Code',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class InputCode extends StatefulWidget {
  const InputCode({super.key});

  @override
  State<InputCode> createState() => _InputCodeState();
}

class _InputCodeState extends State<InputCode> {
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
        color: Theme.of(context).colorScheme.surface,
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

class ResendToken extends StatefulWidget {
  const ResendToken({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<ResendToken> createState() => _ResendTokenState();
}

class _ResendTokenState extends State<ResendToken> {
  final ValueNotifier<int> _time = ValueNotifier<int>(60);

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
          return ElevatedButton(
            onPressed: widget.onPressed,
            child: const Text('Resend Token'),
          );
        } else {
          return Text(
            '00:${value.toString().padLeft(2, '0')}',
            style: const TextStyle(
              color: Colors.grey,
            ),
          );
        }
      },
    );
  }
}
