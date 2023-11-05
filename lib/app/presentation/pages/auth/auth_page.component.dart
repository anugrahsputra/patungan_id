part of 'auth_page.dart';

class Logo extends StatelessWidget {
  Logo({super.key});

  final ChangeThemeMode theme = sl<ChangeThemeMode>();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      theme.isDarkMode() ? LogoPath.logoDark : LogoPath.logoLight,
      width: 90,
      height: 90,
    );
  }
}

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Logo(),
          Text(
            'First,\nLogin Here',
            style: GoogleFonts.inter(
              fontSize: 48,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'enter your mobile number to continue',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

class PhoneField extends StatefulWidget {
  const PhoneField({super.key, required this.controller, required this.ontap});
  final TextEditingController controller;
  final VoidCallback ontap;

  @override
  State<PhoneField> createState() => PhoneFieldState();
}

class PhoneFieldState extends State<PhoneField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PhoneTextField(
          controller: widget.controller,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: DefaultButton(
            onTap: widget.ontap,
            text: AppString.login,
          ),
        ),
      ],
    );
  }
}

class Theme extends StatelessWidget {
  const Theme({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
