import 'package:flutter/material.dart';
import 'package:todo_app/home_layout/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, HomeLayout.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDFECDB),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Image.asset("assets/images/logo.png", width: 140),
              ),
            ),
          ),
          Image.asset("assets/images/Group 7.png")
        ],
      ),
    );
  }
}
