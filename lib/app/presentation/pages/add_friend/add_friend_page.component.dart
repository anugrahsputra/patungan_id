part of 'add_friend_page.dart';

class FriendView extends StatelessWidget {
  FriendView({super.key, required this.user});

  final UserEntity user;
  final AppSettings appSettings = sl<AppSettings>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailUserCubit, DetailUserState>(
        builder: (context, state) {
      return Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: appSettings.isDarkMode() ? Colors.black : Colors.white,
          border: Border.all(
            color: appSettings.isDarkMode() ? Colors.white : Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: appSettings.isDarkMode() ? Colors.white : Colors.black,
              offset: const Offset(2, 4),
              blurRadius: 0,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Column(
          children: [
            AvatarWidget(
              appSettings: appSettings,
              user: user,
              height: 100,
              width: 100,
            ),
            const Gap(15),
            Text(
              user.name,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Gap(5),
            Text(
              user.phoneNumber,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      );
    });
  }
}
