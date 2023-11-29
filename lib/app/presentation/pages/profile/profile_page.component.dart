part of 'profile_page.dart';

class UserHeader extends StatelessWidget {
  UserHeader({super.key});
  final AppSettings appSettings = sl<AppSettings>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (user) {
            return Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: appSettings.isDarkMode()
                    ? const Color.fromARGB(255, 19, 19, 19)
                    : const Color.fromARGB(255, 235, 235, 235),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: appSettings.isDarkMode() ? Colors.white : Colors.black,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        appSettings.isDarkMode() ? Colors.white : Colors.black,
                    offset: const Offset(4, 4),
                    blurRadius: 0,
                    spreadRadius: -1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  AvatarWidget(
                    appSettings: appSettings,
                    user: user!,
                    height: 75,
                    width: 75,
                  ),
                  const Gap(10),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          user.phoneNumber,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          orElse: () => Container(
            width: MediaQuery.sizeOf(context).width,
            height: 200,
            padding: const EdgeInsets.all(50),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: appSettings.isDarkMode()
                  ? const Color.fromARGB(255, 19, 19, 19)
                  : const Color.fromARGB(255, 235, 235, 235),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: appSettings.isDarkMode() ? Colors.white : Colors.black,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: appSettings.isDarkMode() ? Colors.white : Colors.black,
                  offset: const Offset(4, 4),
                  blurRadius: 0,
                  spreadRadius: -1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
