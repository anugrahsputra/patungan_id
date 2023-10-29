import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/core.dart';
import '../../../injection.dart';

class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  final ChangeThemeMode theme = sl<ChangeThemeMode>();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = theme.isDarkMode()
        ? const Color(0xFFFFFFFF).withOpacity(1)
        : const Color(0xFF000000).withOpacity(1);
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: theme.isDarkMode() ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color,
          width: 3,
        ),
        boxShadow: _hasFocus
            ? []
            : [
                BoxShadow(
                  color: color,
                  offset: const Offset(2, 4),
                  blurRadius: 0,
                  spreadRadius: -1,
                ),
              ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              '+62',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.isDarkMode()
                    ? const Color(0xFFFFFFFF).withOpacity(1)
                    : const Color(0xFF000000).withOpacity(1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: VerticalDivider(thickness: 2, color: color),
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.phone,
              cursorColor: color,
              decoration: InputDecoration(
                hintText: AppString.phoneNumber,
                border: InputBorder.none,
                hintStyle: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),

                // contentPadding: const EdgeInsets.only(left: 5),
              ),
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
