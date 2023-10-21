import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultButton extends StatefulWidget {
  const DefaultButton({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
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
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            setState(() {
              isTapped = false;
            });
          },
        );
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 2.5,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF000000).withOpacity(1),
            width: 2,
          ),
          boxShadow: isTapped
              ? []
              : [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(1),
                    offset: const Offset(6, 6),
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
              color: const Color(0xFF000000).withOpacity(1),
            ),
          ),
        ),
      ),
    );
  }
}
