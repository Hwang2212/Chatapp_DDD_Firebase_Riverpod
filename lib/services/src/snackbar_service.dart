import 'package:flutter/material.dart';

class SnackBarService {
  void show(
      {required BuildContext context,
      required String text,
      required String actionText,
      required VoidCallback actionOnPressed,
      int seconds = 2}) {
    ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    scaffoldMessengerState
      ..removeCurrentSnackBar()
      ..showSnackBar(buildSnackBar(
          text: text,
          actionText: actionText,
          seconds: seconds,
          actionOnPressed: actionOnPressed));
  }

  SnackBar buildSnackBar(
      {required String text,
      required String actionText,
      required VoidCallback actionOnPressed,
      int seconds = 2}) {
    return SnackBar(
      duration: Duration(seconds: seconds),
      content: Text(
        text,
      ),
      action: SnackBarAction(
        label: actionText,
        onPressed: actionOnPressed,
      ),
    );
  }
}
