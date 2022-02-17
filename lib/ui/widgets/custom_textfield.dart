import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.height,
    this.label,
    this.controller,
    this.keyboardType,
    this.obscureText,
    this.mask,
    this.hint,
    this.autoFocus,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.suffixIcon,
    this.enabled,
    this.initialValue,
    this.readOnly,
    this.textCapitalization,
    this.padding,
    this.autovalidateMode,
    this.hintStyle,
  });

  final height;
  final label;
  final controller;
  final keyboardType;
  final obscureText;
  final mask;
  final hint;
  final autoFocus;
  final onChanged;
  final enabled;
  final validator;
  final maxLength;
  final suffixIcon;
  final initialValue;
  final readOnly;
  final textCapitalization;
  final padding;
  final autovalidateMode;
  final hintStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55,
      child: TextFormField(
        maxLength: maxLength,
        autovalidateMode: autovalidateMode,
        enabled: enabled,
        validator: validator,
        initialValue: initialValue,
        controller: controller,
        inputFormatters: mask ?? [],
        obscureText: obscureText ?? false,
        autofocus: autoFocus ?? false,
        style: TextStyle(color: Colors.white),
        readOnly: readOnly ?? false,
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          contentPadding: padding,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xffE5E5E5), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xffE5E5E5), width: 1),
          ),
          suffixIcon: suffixIcon,
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          hintText: hint,
          hintStyle: hintStyle,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        onChanged: onChanged,
        onFieldSubmitted: (string) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
