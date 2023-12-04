import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/core.dart';
import '../../../injection.dart';
import '../../presentation.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({
    super.key,
    required this.data,
    required this.profilePic,
  });

  final String data;
  final String profilePic;

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  final AppSettings appSettings = sl<AppSettings>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldBuilder(
      appBar: const DefaultAppBar(),
      onThemeModeChange: (_) => setState(() {}),
      extendBodyBehindAppBar: true,
      backgroundColor: appSettings.isDarkMode() ? Colors.black : Colors.white,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          clipBehavior: Clip.antiAlias,
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: appSettings.isDarkMode() ? Colors.black : Colors.white,
            border: Border.all(
              width: 2,
              color: appSettings.isDarkMode() ? Colors.white : Colors.black,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: appSettings.isDarkMode() ? Colors.white : Colors.black,
                offset: const Offset(4, 4),
                blurRadius: 0,
                spreadRadius: -1,
              ),
            ],
          ),
          child: QrImageView(
            data: widget.data,
            gapless: true,
            embeddedImage: NetworkImage(widget.profilePic),
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: appSettings.isDarkMode() ? Colors.white : Colors.black,
            ),
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: appSettings.isDarkMode() ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
