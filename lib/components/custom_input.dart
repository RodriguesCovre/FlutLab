import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  bool isObscure;
  String labelText;
  // String inputStyle;
  TextEditingController controller;

  CustomInput({super.key, this.isObscure = false, required this.labelText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(), hintText: labelText),
      ),
    );
  }
}
