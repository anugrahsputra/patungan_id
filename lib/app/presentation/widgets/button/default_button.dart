import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/core.dart';
import '../../../injection.dart';

class DefaultButton extends StatefulWidget {
  const DefaultButton({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  bool isTapped = false;

  final ChangeThemeMode theme = sl<ChangeThemeMode>();

  @override
  Widget build(BuildContext context) {
    final color = theme.isDarkMode()
        ? const Color(0xFFFFFFFF).withOpacity(1)
        : const Color(0xFF000000).withOpacity(1);
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
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: theme.isDarkMode()
              ? const Color(0xFF000000).withOpacity(1)
              : const Color(0xFFFFFFFF).withOpacity(1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
            width: 3,
          ),
          boxShadow: isTapped
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
        child: Center(
          child: Text(
            widget.text,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
