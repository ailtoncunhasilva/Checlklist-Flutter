import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustomized extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType inputType;
  final int maxLines;
  final List<TextInputFormatter> inputFormatter;
  final Function(String) validator;
  final Function(String) onSaved;
  final OutlineInputBorder inputBorder;
  final bool autovalidate;

  InputCustomized({
    this.controller,
    @required this.hint,
    this.obscure = false,
    this.autofocus = false,
    this.inputType,
    this.maxLines,
    this.inputFormatter,
    this.validator,
    this.onSaved,
    this.inputBorder,
    this.autovalidate = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      obscureText: this.obscure,
      autofocus: this.autofocus,
      keyboardType: this.inputType,
      inputFormatters: this.inputFormatter,
      validator: this.validator,
      maxLines: this.maxLines,
      onSaved: this.onSaved,
      autovalidate: this.autovalidate,
      decoration: InputDecoration(
        border: this.inputBorder,
        hintText: this.hint,
      ),
    );
  }
}
