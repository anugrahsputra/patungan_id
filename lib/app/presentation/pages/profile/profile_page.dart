import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../../injection.dart';
import '../../presentation.dart';

part 'profile_page.component.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AppSettings appSetting = sl<AppSettings>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldBuilder(
      appBar: DefaultAppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      onThemeModeChange: (_) => setState(() {}),
      backgroundColor: appSetting.isDarkMode() ? Colors.black : Colors.white,
      body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        return state.maybeWhen(
          loaded: (user) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserHeader(user: user!),
                  const Gap(20),
                  MenuCard(),
                ],
              ),
            );
          },
          orElse: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
        );
      }),
    );
  }
}
