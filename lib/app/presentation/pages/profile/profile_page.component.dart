part of 'profile_page.dart';

class UserHeader extends StatelessWidget {
  UserHeader({super.key, required this.user});
  final AppSettings appSettings = sl<AppSettings>();
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
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
            color: appSettings.isDarkMode() ? Colors.white : Colors.black,
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
            user: user,
            height: 55.0,
            width: 55.0,
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
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
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
  }
}

class MenuCard extends StatelessWidget {
  MenuCard({super.key, this.user});
  final UserEntity? user;

  final AppSettings appSettings = sl<AppSettings>();
  final AppNavigator navigate = sl<AppNavigator>();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: MediaQuery.sizeOf(context).width,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
          children: [
            MenuItems(
              appSettings: appSettings,
              menuText: 'QRCode',
              onTap: () {
                String data = user!.id;
                navigate.gotoQrCode(context, data: data);
              },
            ),
            MenuItems(
              appSettings: appSettings,
              menuText: 'Edit Profile',
            ),
            MenuItems(
              appSettings: appSettings,
              menuText: 'QRCode',
            ),
            MenuItems(
              appSettings: appSettings,
              menuText: 'Edit Profile',
            )
          ],
        ));
  }
}

class MenuItems extends StatefulWidget {
  const MenuItems({
    super.key,
    required this.appSettings,
    required this.menuText,
    this.onTap,
  });
  final AppSettings appSettings;
  final String menuText;
  final VoidCallback? onTap;

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (details) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isTapped = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.appSettings.isDarkMode()
              ? const Color.fromARGB(255, 19, 19, 19)
              : const Color.fromARGB(255, 235, 235, 235),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color:
                widget.appSettings.isDarkMode() ? Colors.white : Colors.black,
            width: 3,
          ),
          boxShadow: isTapped
              ? []
              : [
                  BoxShadow(
                    color: widget.appSettings.isDarkMode()
                        ? Colors.white
                        : Colors.black,
                    offset: const Offset(4, 4),
                    blurRadius: 0,
                    spreadRadius: -1,
                  ),
                ],
        ),
        child: Text(
          widget.menuText,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
