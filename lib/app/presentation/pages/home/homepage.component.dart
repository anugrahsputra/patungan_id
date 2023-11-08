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

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({
    super.key,
    required this.user,
  });

  final UserEntity? user;

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  final ChangeThemeMode themeMode = sl<ChangeThemeMode>();

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.user?.profilePic ?? ''),
        ),
        const Gap(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting(),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                color: themeMode.isDarkMode() ? Colors.white : Colors.black,
              ),
            ),
            Text(
              widget.user?.name ?? 'User',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: themeMode.isDarkMode() ? Colors.white : Colors.black,
              ),
            )
          ],
        ),
      ],
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
  final ChangeThemeMode themeMode = sl<ChangeThemeMode>();
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: const [
          QuickMenu(),
        ],
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
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(2),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QuickMenuItem(icon: Icons.group_add_outlined),
            QuickMenuItem(icon: Icons.person_add_alt),
            QuickMenuItem(icon: Icons.receipt_outlined),
            QuickMenuItem(
              icon: Icons.more_horiz_outlined,
            )
          ],
        ));
  }
}

class QuickMenuItem extends StatefulWidget {
  const QuickMenuItem({
    super.key,
    this.icon,
  });

  final IconData? icon;

  @override
  State<QuickMenuItem> createState() => _QuickMenuItemState();
}

class _QuickMenuItemState extends State<QuickMenuItem> {
  final ChangeThemeMode themeMode = sl<ChangeThemeMode>();
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (details) {
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            isTapped = false;
          });
        });
      },
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: themeMode.isDarkMode()
              ? const Color(0xFF000000).withOpacity(1)
              : const Color(0xFFFFFFFF).withOpacity(1),
          border: Border.all(
            color: themeMode.isDarkMode() ? Colors.white : Colors.black,
          ),
          boxShadow: isTapped
              ? []
              : [
                  BoxShadow(
                    color: themeMode.isDarkMode()
                        ? const Color(0xFFFFFFFF).withOpacity(1)
                        : const Color(0xFF000000).withOpacity(1),
                    offset: const Offset(4, 4),
                    blurRadius: 0,
                    spreadRadius: -1,
                  ),
                ],
        ),
        child: Icon(
          widget.icon,
          color: themeMode.isDarkMode()
              ? const Color(0xFFFFFFFF).withOpacity(1)
              : const Color(0xFF000000).withOpacity(1),
        ),
      ),
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
