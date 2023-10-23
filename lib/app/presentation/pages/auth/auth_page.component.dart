part of 'auth_page.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF000000).withOpacity(1),
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(1),
            offset: const Offset(6, 6),
            blurRadius: 0,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Text(
        'Enter Your Phone Number To Continue',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
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
        DefaultButton(
          onTap: widget.ontap,
          text: AppString.login,
        ),
      ],
    );
  }
}
