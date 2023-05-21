import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);

class CustomFormField extends StatefulWidget {
  String label;
  bool isPassword;
  TextInputType keyboardType;
  MyValidator validator;
  TextEditingController controller;
  IconButton? showPassword;
  bool showPasswordValue = true;

  CustomFormField(
      {super.key,
      required this.label,
      this.isPassword = false,
      this.keyboardType = TextInputType.text,
      required this.validator,
      required this.controller,
      required this.showPasswordValue});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    if (widget.isPassword) {
      widget.showPassword = IconButton(
        onPressed: () {
          if (widget.showPasswordValue) {
            widget.showPasswordValue = false;
          } else {
            widget.showPasswordValue = true;
          }
          setState(() {});
        },
        icon: Icon(!widget.showPasswordValue
            ? Icons.visibility_off
            : Icons.visibility),
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: widget.showPasswordValue,
        decoration: InputDecoration(
            labelText: widget.label,
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(7)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(7)),
            suffixIcon: widget.showPassword),
      ),
    );
  }
}
