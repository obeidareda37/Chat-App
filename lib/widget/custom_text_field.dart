import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  Icon prefixIcon;
  Icon suffixIcon;
  TextInputType textInputType;
  Function onChange;

  CustomTextField({
    this.hint,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputType,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: textInputType,
        controller: this.controller,
        onChanged: onChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          hintText: hint,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
