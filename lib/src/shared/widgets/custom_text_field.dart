import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomRoundedTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool? readOnly;
  final Widget? prefixIcon;
  final List<TextInputFormatter> inputFormatters;
  final bool visibilityIcons;
  final int? maxLength;
  final Function(String)? onChanged;
  const CustomRoundedTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.readOnly,
    this.prefixIcon,
    this.maxLength,
    this.onChanged,
    this.obscureText = false,
    this.visibilityIcons = false,
    this.inputFormatters = const [],
  });

  @override
  State<CustomRoundedTextField> createState() => _CustomRoundedTextFieldState();
}

class _CustomRoundedTextFieldState extends State<CustomRoundedTextField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() {
    if (widget.initialValue != null && widget.controller != null) {
      AppConstants.setTextFieldValue(
        text: widget.initialValue!,
        controller: widget.controller!,
      );
    }

    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      // style: Theme.of(context).textTheme.bodyMedium,
      inputFormatters: widget.inputFormatters,
      obscureText: obscureText,
      controller: widget.controller,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.kHintText),
        labelStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.kHintText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.kTextField),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.kPrimary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.kTextField),
        ),
        prefixIcon: widget.prefixIcon,
        filled: true,
        fillColor: AppColors.kTextField,
        suffixIcon: widget.suffixIcon != null
            ? widget.suffixIcon!
            : widget.visibilityIcons
                ? GestureDetector(
                    onTap: () => setState(() => obscureText = !obscureText),
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.kPrimary,
                    ),
                  )
                : null,
      ),
    );
  }
}
