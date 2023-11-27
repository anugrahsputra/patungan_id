part of 'homepage.dart';

class Loading extends StatelessWidget {
  Loading({super.key});

  final AppSettings themeMode = sl<AppSettings>();

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

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  final AppSettings themeMode = sl<AppSettings>();

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            // TODO: use shimmer loading effect
            return const SizedBox.shrink();
          },
          loaded: (userEntity) {
            UserEntity? user = userEntity;
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user?.profilePic ?? ''),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting(),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      user?.name ?? 'User',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ContentView extends StatefulWidget {
  const ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  final AppSettings themeMode = sl<AppSettings>();
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [const QuickMenu(), GroupCards(), SignOutBtn()],
      ),
    );
  }
}

class QuickMenu extends StatefulWidget {
  const QuickMenu({
    super.key,
  });

  @override
  State<QuickMenu> createState() => _QuickMenuState();
}

class _QuickMenuState extends State<QuickMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              QuickMenuItem(
                icon: Icons.group_add_outlined,
                onTap: () {},
              ),
              QuickMenuItem(icon: Icons.person_add_alt, onTap: () {}),
              QuickMenuItem(icon: Icons.receipt_outlined, onTap: () {}),
              QuickMenuItem(
                icon: Icons.more_horiz_outlined,
                onTap: () {},
              )
            ],
          ),
        );
      },
    );
  }
}

class GroupCards extends StatelessWidget {
  GroupCards({super.key});
  final AppSettings themeMode = sl<AppSettings>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: themeMode.isDarkMode() ? Colors.white : Colors.black,
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
