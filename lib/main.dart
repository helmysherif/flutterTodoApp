import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/register_screen.dart';
import 'package:todo_app/styles/my_themes.dart';
import 'package:todo_app/home_layout/home_screen.dart';
import 'package:todo_app/splash_layout/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        HomeLayout.routeName: (_) => HomeLayout(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        LoginScreen.routeName: (_) => const LoginScreen()
      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
