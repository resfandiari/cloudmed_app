import 'package:flutter/material.dart';

class TextInputCustom extends StatelessWidget {
  final String labelText;
  final int maxLines;
  final int maxLength;
  final bool autofocus;
  final keyboardType;
  final validator;
  final onSaved;
  final initialValue;
  final controller;
  final inputFormatters;
  final onChanged;
  final TextStyle style;
  final Icon icon;
  final textAlign;
  final textDirection;
  final readOnly;
  final onTap;
  final TextStyle labelStyle;
  final focusNode;
  final suffixIcon;
  final enabled;
  final filled;
  final colorFocusedBorder;
  final colorEnabledBorder;
  final obscureText;
  final String hintText;
  final TextStyle hintStyle;

  TextInputCustom(
      {this.controller,
      this.labelText,
      this.maxLines,
      this.maxLength,
      this.validator,
      this.keyboardType,
      this.autofocus: false,
      this.initialValue,
      this.inputFormatters,
      this.onChanged,
      this.style,
      this.icon,
      this.onTap,
      this.colorFocusedBorder: Colors.lightBlueAccent,
      this.colorEnabledBorder: Colors.grey,
      this.readOnly: false,
      this.labelStyle,
      this.textAlign = TextAlign.right,
      this.textDirection = TextDirection.rtl,
      this.onSaved,
      this.suffixIcon,
      this.focusNode,
      this.hintStyle,
      this.hintText,
      this.enabled,
      this.obscureText: false,
      this.filled});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      controller: controller,
      initialValue: initialValue,
      autofocus: autofocus,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textAlign: textAlign,
      onTap: onTap,
      obscureText: obscureText,
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        icon: icon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        filled: filled,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorEnabledBorder, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorFocusedBorder, width: 2)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2)),
        errorStyle: TextStyle(color: Colors.redAccent),
      ),
      textDirection: TextDirection.rtl,
      maxLines: maxLines,
      maxLength: maxLength,
      onSaved: onSaved,
      validator: validator,
      focusNode: focusNode,
      enabled: enabled,
    );
  }
}
