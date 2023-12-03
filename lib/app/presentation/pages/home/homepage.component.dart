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
    this.onTap,
  });

  final void Function()? onTap;

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
                GestureDetector(
                  onTap: widget.onTap,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user?.profilePic ?? ''),
                  ),
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
  final AppNavigator navigate = sl<AppNavigator>();

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
              QuickMenuItem(
                icon: Icons.person_add_alt,
                onTap: () {
                  navigate.goToQrScanPage(context);
                },
              ),
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

class GrousView extends StatelessWidget {
  const GrousView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Text('loading groups'),
          loaded: (userEntity) {
            UserEntity? user = userEntity;
            List<String>? groups = user?.groupId;
            return ListView.builder(
              itemCount: groups!.length,
              itemBuilder: (BuildContext context, int index) {
                return const SizedBox();
              },
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class GroupCards extends StatelessWidget {
  GroupCards({super.key});
  final AppSettings themeMode = sl<AppSettings>();

  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.amber,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    final color = themeMode.isDarkMode()
        ? const Color(0xFFFFFFFF).withOpacity(1)
        : const Color(0xFF000000).withOpacity(1);
    final containerColor = themeMode.isDarkMode()
        ? const Color(0xFF000000).withOpacity(1)
        : const Color(0xFFFFFFFF).withOpacity(1);
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: color,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: color,
            offset: const Offset(2, 4),
            blurRadius: 0,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Benteng Laper',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Rp. 100.000',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 80,
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Transform.translate(
                        offset: Offset(-20.0 * index, 0),
                        child: CircleAvatar(
                          backgroundColor: colors[index],
                          radius: 25.0,
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '80%',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Paid',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SignOutBtn extends StatelessWidget {
  SignOutBtn({super.key});

  final AppNavigator navigator = sl<AppNavigator>();
  final AuthCubit authCubit = sl<AuthCubit>();
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
          onTap: () async => await context.read<AuthCubit>().signOUt(),
        );
      },
    );
  }
}
