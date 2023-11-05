import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/core.dart';
import '../../../injection.dart';

class DefaultTextField extends StatefulWidget {
  const DefaultTextField(
      {super.key, required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
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
          width: 2,
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
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              hintStyle: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              contentPadding: const EdgeInsets.only(left: 20),
            ),
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
