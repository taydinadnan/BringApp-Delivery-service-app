import 'package:flutter/material.dart';
import 'package:sellers_food_app/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController anyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: anyController,
          data: Icons.phone,
          hintText: "Username",
          isObsecre: false,
          enabled: true,
        ),
        CustomTextField(
          controller: anyController,
          data: Icons.phone,
          hintText: "Password",
          isObsecre: true,
          enabled: true,
        ),
      ],
    );
  }
}
