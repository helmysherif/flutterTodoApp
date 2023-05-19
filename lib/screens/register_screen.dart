import 'package:flutter/material.dart';
import 'package:todo_app/styles/app_colors.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "register";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: lightGreenColor,
          image:
              DecorationImage(image: AssetImage("assets/images/Group 2.png"))),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
