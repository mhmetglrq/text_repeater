import 'package:flutter/material.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';

import '../items/borders/input_borders.dart';


class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.labelText,
    required TextEditingController controller,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    this.hintText,
    this.keyboardType,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        hintText: hintText,
        labelStyle: context.textTheme.titleMedium,
        border: InputBorders.outlineInputBorder,
        focusedBorder: InputBorders.focusedInputBorder,
        errorBorder: InputBorders.errorInputBorder,
        disabledBorder: InputBorders.disabledInputBorder,
        enabledBorder: InputBorders.enabledInputBorder,
        focusedErrorBorder: InputBorders.focusedErrorInputBorder,
      ),
      validator: validator,
    );
  }
}
