import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String? message;

  const ErrorDialog({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        ElevatedButton(
          child: const Center(
            child: Text(
              "Ok",
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
