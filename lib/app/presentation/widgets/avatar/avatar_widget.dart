import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.appSettings,
    required this.user,
    required this.height,
    required this.width,
  });

  final AppSettings appSettings;
  final UserEntity user;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: appSettings.isDarkMode()
            ? const Color.fromARGB(255, 19, 19, 19)
            : const Color.fromARGB(255, 235, 235, 235),
        shape: BoxShape.circle,
        border: Border.all(
          color: appSettings.isDarkMode() ? Colors.white : Colors.black,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: appSettings.isDarkMode() ? Colors.white : Colors.black,
            offset: const Offset(4, 4),
            blurRadius: 0,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Image.network(
        user.profilePic,
      ),
    );
  }
}
