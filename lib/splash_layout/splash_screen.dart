import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home_layout/home_screen.dart';
import 'package:todo_app/screens/register_screen.dart';

import '../providers/my_provider.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(
          context,
          provider.firebaseUser != null
              ? HomeLayout.routeName
              : RegisterScreen.routeName);
    });
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
