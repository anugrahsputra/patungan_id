import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../../injection.dart';
import '../../presentation.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcode;
  bool isStarted = true;
  String userId = '';

  final Logger log = Logger("qr scan page");

  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  final AppNavigator navigate = sl<AppNavigator>();
  final GetCurrentIdUsecase getCurrentId = sl<GetCurrentIdUsecase>();

  void getCurrentIds() async {
    final result = await getCurrentId.call();
    result.fold((l) {
      log.severe(l.message);
    }, (currentId) {
      userId = currentId;
      log.shout(userId);
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentIds();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBuilder(
      appBar: const DefaultAppBar(
        title: Text('Scan your friend qrcode'),
      ),
      onThemeModeChange: (_) => setState(() {}),
      body: Builder(
        builder: (context) {
          return MobileScanner(
            controller: cameraController,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            fit: BoxFit.cover,
            overlay: Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 3),
                ),
              ),
            ),
            onDetect: (barcode) {
              setState(() {
                this.barcode = barcode;
              });
              String? uid = barcode.barcodes.first.rawValue;
              cameraController.stop();
              if (uid != userId) {
                navigate.goToAddFriend(context, friendId: uid!);
                cameraController.start();
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          'Are you trying to add yourself as a friend? :('),
                      actions: [
                        FilledButton(
                          child: const Text('Close'),
                          onPressed: () {
                            navigate.back(context);
                            cameraController.start();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    getCurrentIds();
    super.dispose();
  }
}

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({super.key, required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';
        break;
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permission denied';
        break;
      case MobileScannerErrorCode.unsupported:
        errorMessage = 'Scanning is unsupported on this device';
        break;
      default:
        errorMessage = 'Generic Error';
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              error.errorDetails?.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
