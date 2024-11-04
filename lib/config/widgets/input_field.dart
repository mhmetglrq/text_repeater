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
    this.expands = false,
    this.maxLines,
    this.minLines,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool expands;
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.justify,
      textAlignVertical: TextAlignVertical.top,
      expands: expands,
      maxLines: maxLines,
      minLines: minLines,
      controller: _controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        alignLabelWithHint: true,
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
