import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: library_prefixes
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_food_app/authentication/login.dart';

import '../global/global.dart';
import '../screens/home_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/error_dialog.dart';
import '../widgets/header_widget.dart';
import '../widgets/loading_dialog.dart';

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

//image picker
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

//seller image url
  String userImageUrl = "";

//function for getting image
  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
    });
  }

//Form Validation
  Future<void> signUpFormValidation() async {
    //checking if user selected image
    if (imageXFile == null) {
      setState(
        () {
          // imageXFile == "images/bg.png";
          showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "Please select an image",
              );
            },
          );
        },
      );
    } else {
      if (passwordController.text == confirmpasswordController.text) {
        //nested if (cheking if controllers empty or not)
        if (confirmpasswordController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            nameController.text.isNotEmpty) {
          //start uploading image
          showDialog(
            context: context,
            builder: (c) {
              return const LoadingDialog(
                message: "Registering Account",
              );
            },
          );

          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance
              .ref()
              .child("users")
              .child(fileName);
          fStorage.UploadTask uploadTask =
              reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            userImageUrl = url;

            // save info to firestore
            AuthenticateSellerAndSignUp();
          });
        }
        //if there is empty place show this message
        else {
          showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "Please fill the required info for Registration. ",
              );
            },
          );
        }
      } else {
        //show an error if passwords do not match
        showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Password do not match",
            );
          },
        );
      }
    }
  }

  // ignore: non_constant_identifier_names
  void AuthenticateSellerAndSignUp() async {
    User? currentUser;
    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError(
      (error) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          },
        );
      },
    );

    if (currentUser != null) {
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);
        //send user to Home Screen
        Route newRoute = MaterialPageRoute(builder: (c) => const HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

//saving seller information to firestore
  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set(
      {
        "uid": currentUser.uid,
        "email": currentUser.email,
        "name": nameController.text.trim(),
        "photoUrl": userImageUrl,
        "status": "approved",
        "userCart": ['garbageValue'],
      },
    );

    // save data locally (to access data easly from phone storage)
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", userImageUrl);
    await sharedPreferences!.setStringList(
        "userCart", ['garbageValue']); //empty cart list while registration
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(-2.0, 0.0),
            end: FractionalOffset(5.0, -1.0),
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFAC898),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  const SizedBox(
                    height: 150,
                    child: HeaderWidget(
                      150,
                      false,
                      Icons.add,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        _getImage();
                      },
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
                                Icons.person_add_alt_1,
                                size: MediaQuery.of(context).size.width * 0.20,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
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
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 5.0)
                    ],
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        Colors.amber,
                        Colors.black,
                      ],
                    ),
                    color: Colors.deepPurple.shade300,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(50, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        'Sign Up'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      signUpFormValidation();
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: 'Login',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
