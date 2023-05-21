import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/components/custom_form_field.dart';
import 'package:todo_app/shared/components/dialog_utils.dart';
import 'package:todo_app/shared/validation_utils.dart';
import 'package:todo_app/styles/app_colors.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();

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
          title: const Text("Register"),
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
                    controller: nameController,
                    label: "Full Name",
                    showPasswordValue: false,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter full name";
                      }
                      return null;
                    },
                  ),
                  CustomFormField(
                    controller: emailController,
                    label: "Email Address",
                    showPasswordValue: false,
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
                  CustomFormField(
                    controller: passwordConfirmationController,
                    label: "Password Confirmation",
                    showPasswordValue: true,
                    isPassword: true,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter Password Confirmation";
                      }
                      if (passwordController.text != text) {
                        return "password doesn't match";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 0),
                    child: Text(
                      "Register",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: const Text("Already have an account?",
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

  void register() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    // register logic
    DialogUtils.showLoadingDialog(context, "loading...");
    try {
      var res = await authServices.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, "successful registeration");
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = "Something went wrong!";
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      DialogUtils.showMessage(context, errorMessage,
          postActionName: "Ok", negativeActionName: "Cancel");
    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = "Something went wrong!";
      DialogUtils.showMessage(context, errorMessage,
          postActionName: "Cancel",
          negativeActionName: "Try Again", negativeCallback: () {
        register();
      });
    }
  }
}
