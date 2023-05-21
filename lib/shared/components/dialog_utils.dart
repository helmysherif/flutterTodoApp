import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Text(message)
              ],
            ),
          );
        },
        barrierDismissible: false);
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(BuildContext context, String message,
      {String? postActionName,
      String? negativeActionName,
      VoidCallback? positiveCallback,
      VoidCallback? negativeCallback}) {
    List<Widget> actions = [];
    if (postActionName != null) {
      actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          positiveCallback?.call();
        },
        child: Text(postActionName, style: const TextStyle(fontSize: 18)),
      ));
    }
    if (negativeActionName != null) {
      actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          negativeCallback?.call();
        },
        child: Text(negativeActionName, style: const TextStyle(fontSize: 18)),
      ));
    }
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Text(message),
            actions: actions,
          );
        });
  }
}
