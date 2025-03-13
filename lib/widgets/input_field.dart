import 'package:flutter/material.dart';

import '../theme.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final Widget suffixIcon;
  TextInputType? keyBoardType;
  final TextEditingController controller;

   InputField({
    Key? key,
    required this.hintText,
    this.errorText,
    this.obscureText = false,
    required this.suffixIcon,
    required this.controller,
    this.keyBoardType

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textWhiteGrey,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyBoardType,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          hintStyle: heading6.copyWith(color: textGrey),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
