    import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext context, Map<String, dynamic> result) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Payment Successful"),
        content: Text("Details:\n${result.toString()}"),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void showFailureDialog(BuildContext context, Map<String, dynamic> result) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Payment Failed"),
        content: Text("Details:\n${result.toString()}"),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("Try Again"),
          )
        ],
      ),
    );
  }
