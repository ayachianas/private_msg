// Packages
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;

  const CustomTextFormField({
    required this.onSaved,
    required this.regEx,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (_value) => onSaved(_value!),
      cursorColor: Colors.blue,
      style: const TextStyle(color: Colors.blue),
      obscureText: obscureText,
      validator: (_value) {
        return RegExp(regEx).hasMatch(_value!) ? null : 'Enter a valid value. ';
      },
      decoration: InputDecoration(
        fillColor: Colors.grey,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white70,
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final Function(String) onEditingComplete;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  IconData? icon;

  CustomTextField({
    required this.onEditingComplete,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: onEditingComplete(controller.value.text),
      cursorColor: Colors.grey,
      style: TextStyle(
        color: Colors.black,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: Colors.blue,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
    );
  }
}
