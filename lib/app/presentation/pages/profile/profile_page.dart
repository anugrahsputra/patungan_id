import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../injection.dart';
import '../../presentation.dart';

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
      onThemeModeChange: (_) => setState(() {}),
      backgroundColor: appSetting.isDarkMode() ? Colors.black : Colors.white,
      body: const Center(
        child: Text('profilePage'),
      ),
    );
  }
}
