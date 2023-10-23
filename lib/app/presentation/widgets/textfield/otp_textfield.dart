import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPTextField extends StatelessWidget {
  const OTPTextField({
    super.key,
    this.onCompleted,
    this.controller,
    this.focusNode,
  });

  final Function(String value)? onCompleted;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  int get length => 6;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: PinCodeTextField(
        appContext: context,
        focusNode: focusNode,
        length: length,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        enableActiveFill: true,
        obscureText: false,
        hintCharacter: '-',
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        cursorHeight: 24.0,
        cursorColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        controller: controller,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderWidth: 1,
          fieldWidth: 40,
          fieldHeight: 40,
          activeColor: Theme.of(context).primaryColor.withOpacity(0.1),
          activeFillColor: Colors.transparent,
          inactiveFillColor: Colors.transparent,
          selectedFillColor: Colors.transparent,
          errorBorderColor: Theme.of(context).primaryColor.withOpacity(0.1),
          inactiveColor: Colors.black54,
          selectedColor: Colors.black,
        ),
        onChanged: (value) {
          if (value.length == length && onCompleted != null) {
            onCompleted!(value);
          }
        },
      ),
    );
  }
}
