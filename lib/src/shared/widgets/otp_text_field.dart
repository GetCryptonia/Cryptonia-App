import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOtpTextField extends StatelessWidget {
  final int length;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  const CustomOtpTextField(
      {super.key, this.controller, this.length = 6, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return PinCodeTextField(
          length: length,
          appContext: context,
          obscureText: false,
          controller: controller,
          animationType: AnimationType.fade,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            activeFillColor: AppColors.kTextField,
            inactiveFillColor: AppColors.kTextField,
            selectedColor: AppColors.kPrimary,
            activeColor: AppColors.kPrimary,
            inactiveColor: AppColors.kTextField,
            selectedFillColor: AppColors.kTextField,
            fieldHeight: 60,
            fieldWidth: (constraints.maxWidth - 50) / length,
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          onCompleted: (v) {},
          onChanged: onChanged,
          beforeTextPaste: (text) {
            // print("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        );
      },
    );
  }
}
