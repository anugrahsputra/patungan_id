part of 'homepage.dart';

class Loading extends StatelessWidget {
  Loading({super.key});

  final ChangeThemeMode themeMode = sl<ChangeThemeMode>();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(24),
      child: LoadingAnimationWidget.stretchedDots(
          color: themeMode.isDarkMode() ? Colors.white : Colors.black,
          size: 69),
    );
  }
}

class ContentView extends StatefulWidget {
  const ContentView({super.key, required this.user});

  final UserEntity? user;

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.user?.name ?? ''),
        const SizedBox(height: 10),
        SignOutBtn(),
      ],
    );
  }
}

class SignOutBtn extends StatelessWidget {
  SignOutBtn({super.key});

  final AppNavigator navigator = sl<AppNavigator>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
            success: () => navigator.goToSplah(context),
            error: (_) {},
            otpResent: () {});
      },
      builder: (context, state) {
        return DefaultButton(
          text: AppString.logout,
          onTap: () async => await AuthCubit.get(context).signOUt(),
        );
      },
    );
  }
}
