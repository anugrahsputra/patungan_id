import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/core.dart';
import '../../../injection.dart';
import '../../presentation.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  final AppNavigator navigate = sl<AppNavigator>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldBuilder(
      appBar: const DefaultAppBar(),
      extendBodyBehindAppBar: true,
      onThemeModeChange: (theme) => setState(() {}),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Lottie.asset(
            LottiePath.notFound,
            repeat: true,
          ),
          Text(
            'Page Not Found, maybe go back?',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          DefaultButton(
            onTap: () {
              navigate.goToSplah(context);
            },
            text: 'Go back',
          )
        ],
      ),
    );
  }
}
