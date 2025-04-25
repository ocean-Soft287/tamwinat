import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static closeDialogHelper(BuildContext context) {
    Navigator.of(context).pop();
  }

  static showDialogHelper(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrange,
              color: Colors.white,
            ),
          );
        });
  }
}
