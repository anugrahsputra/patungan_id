import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../presentation.dart';

class AppBottomSheet {
  late BuildContext context;
  AppBottomSheet(this.context);

  final double topRadius = 30;

  Future<void> verifyOtp(
    context, {
    Function(String value)? onCompletedCode,
    VoidCallback? onResendCode,
  }) async {
    FocusNode focusNode = FocusNode();
    await showMaterialModalBottomSheet(
      useRootNavigator: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius),
          topRight: Radius.circular(topRadius),
        ),
      ),
      builder: (context) => GestureDetector(
        onTap: () => focusNode.unfocus(),
        child: Container(
          height: MediaQuery.of(context).size.height / 2.20 +
              (MediaQuery.of(context).viewInsets.bottom > 0 ? 100 : 0),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          color: Colors.transparent,
          alignment: Alignment.topCenter,
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Enter OTP Code',
                      style: GoogleFonts.inter(),
                    ),
                    const SizedBox(height: 5),
                    OTPTextField(
                      onCompleted: onCompletedCode,
                      focusNode: focusNode,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void close() {
    if (ModalRoute.of(context)?.isCurrent != true &&
        Navigator.of(context).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
