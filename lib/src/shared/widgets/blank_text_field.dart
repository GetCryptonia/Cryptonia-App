import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlankTextField extends StatelessWidget {
  final String? hint;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const BlankTextField({
    super.key,
    this.hint,
    required this.formatters,
    this.controller,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.all(0),
        hintStyle: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(color: AppColors.kHintText),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
