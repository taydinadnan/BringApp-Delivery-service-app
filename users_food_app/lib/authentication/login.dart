import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';
import '../screens/home_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import 'auth_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

//form validation for login
  formValidation() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //login
      loginNow();
    } else {
      showDialog(
        context: context,
        builder: (c) {
          return const ErrorDialog(
            message: "Please enter email/password.",
          );
        },
      );
    }
  }

//login function
  loginNow() async {
    showDialog(
      context: context,
      builder: (c) {
        return const LoadingDialog(
          message: "Checking Credentials...",
        );
      },
    );

    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then(
      (auth) {
        currentUser = auth.user!;
      },
    ).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: error.message.toString(),
          );
        },
      );
    });
    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
    }
  }

//read data from firestore and save it locally
  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then(
      (snapshot) async {
        //check if the user is user
        if (snapshot.exists) {
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!
              .setString("email", snapshot.data()!["email"]);
          await sharedPreferences!.setString("name", snapshot.data()!["name"]);
          await sharedPreferences!
              .setString("photoUrl", snapshot.data()!["photoUrl"]);

          //get cart list from firebase
          List<String> userCartList =
              snapshot.data()!["userCart"].cast<String>();
          await sharedPreferences!.setStringList("userCart", userCartList);

          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => HomeScreen(),
            ),
          );
        }
        //if user is not a user
        else {
          firebaseAuth.signOut();
          Navigator.pop(context);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const AuthScreen(),
            ),
          );
          showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "No record exist.",
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                'images/login.png',
                height: 270,
              ),
            ),
          ),
          const Center(
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 40,
                color: Colors.orange,
                fontFamily: "Signatra",
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
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
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      formValidation();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
