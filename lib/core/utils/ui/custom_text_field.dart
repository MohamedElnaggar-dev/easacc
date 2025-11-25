import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.validator,
    required this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
  });
  final String hintText;
  final String? Function(String?)? validator;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: outLineInputBorder(color: Colors.grey),
        focusedBorder: outLineInputBorder(color: Colors.grey),
        errorBorder: outLineInputBorder(color: Colors.red),
        focusedErrorBorder: outLineInputBorder(color: Colors.red),
      ),
    );
  }

  OutlineInputBorder outLineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: color),
    );
  }
}
