import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers_food_app/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10),
            InkWell(
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile == null
                    ? null
                    : FileImage(
                        File(imageXFile!.path),
                      ),
                child: imageXFile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: MediaQuery.of(context).size.width * 0.20,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    data: Icons.person,
                    controller: nameController,
                    hintText: "Name",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.email,
                    controller: emailController,
                    hintText: "Email",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: passwordController,
                    hintText: "Password",
                    isObsecre: true,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: confirmpasswordController,
                    hintText: "Confirm password",
                    isObsecre: true,
                  ),
                  CustomTextField(
                    data: Icons.phone_android_outlined,
                    controller: phoneController,
                    hintText: "Phone nummber",
                    isObsecre: false,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 300,
                        child: CustomTextField(
                          data: Icons.my_location,
                          controller: locationController,
                          hintText: "Cafe/Restorant Address",
                          isObsecre: false,
                          enabled: false,
                        ),
                      ),
                      Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.location_on,
                            size: 40,
                          ),
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  // Container(
                  //   width: 60,
                  //   height: 50,
                  //   alignment: Alignment.center,
                  //   child: ElevatedButton.icon(
                  //     onPressed: () {},
                  //     icon: const Icon(Icons.location_history),
                  //     label: const Text(
                  //       "",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //       primary: Colors.orange,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
