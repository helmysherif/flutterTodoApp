import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/shared/network/firebase/firebase_functions.dart';

class MyProvider extends ChangeNotifier {
  UserModel? myUser;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    myUser = await FireBaseFunctions.readUser(firebaseUser!.uid);
    notifyListeners();
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
