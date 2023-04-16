import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  String? hint;
  final TextEditingController? controller;

  MyTextField({Key? key, this.hint, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(
          hintText: hint,
        ),
        validator: (value) => value!.isEmpty ? "Field can not be empty" : null,
      ),
    );
  }
}
