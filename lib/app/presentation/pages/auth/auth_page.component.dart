part of 'auth_page.dart';

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
        DefaultTextField(
          controller: widget.controller,
          hintText: AppString.phoneNumber,
        ),
        const SizedBox(height: 10),
        DefaultButton(
          onTap: widget.ontap,
          text: AppString.login,
        ),
      ],
    );
  }
}
