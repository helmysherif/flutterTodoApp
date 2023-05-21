import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/home_layout/home_screen.dart';
import 'package:todo_app/screens/register_screen.dart';
import '../shared/components/custom_form_field.dart';
import '../shared/components/dialog_utils.dart';
import '../shared/validation_utils.dart';
import '../styles/app_colors.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: lightGreenColor,
          image: DecorationImage(
              image: AssetImage("assets/images/SIGN IN – 1.png"),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("login"),
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  CustomFormField(
                    controller: emailController,
                    showPasswordValue: false,
                    label: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter email";
                      }
                      if (!ValidationUtils.isValidEmail(text)) {
                        return "please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  CustomFormField(
                    controller: passwordController,
                    label: "Password",
                    showPasswordValue: true,
                    isPassword: true,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter password";
                      }
                      if (text.length < 6) {
                        return "password should be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 0),
                    child: Text(
                      "Login",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RegisterScreen.routeName);
                    },
                    child: const Text("Don't have an account?",
                        style: TextStyle(fontSize: 17)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FirebaseAuth authServices = FirebaseAuth.instance;

  void login() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    // register logic
    DialogUtils.showLoadingDialog(context, "loading...");
    try {
      var res = await authServices.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, "successful login");
      Navigator.pushReplacementNamed(context, HomeLayout.routeName);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = "Wrong email or password!";
      DialogUtils.showMessage(context, errorMessage,
          postActionName: "Ok", negativeActionName: "Cancel");
    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = "Something went wrong!";
      DialogUtils.showMessage(context, errorMessage,
          postActionName: "Cancel",
          negativeActionName: "Try Again", negativeCallback: () {
        login();
      });
    }
  }
}
