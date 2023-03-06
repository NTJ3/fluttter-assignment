import 'package:flutter/material.dart';

showToast(String message, BuildContext context, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Text(
          message,
          textAlign: TextAlign.left,
        ),
      ),
      duration: const Duration(milliseconds: 2000),
      backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade600,
    ),
  );
}
