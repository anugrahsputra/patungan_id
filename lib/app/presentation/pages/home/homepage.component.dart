part of 'homepage.dart';

class SignOutBtn extends StatelessWidget {
  SignOutBtn({super.key});

  final AppNavigator navigator = sl<AppNavigator>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () => navigator.goToSplah(context),
        );
      },
      builder: (context, state) {
        return DefaultButton(
          text: AppString.logout,
          onTap: () => AuthCubit.get(context).signOUt(),
        );
      },
    );
  }
}
