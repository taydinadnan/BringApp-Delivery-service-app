import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_food_app/authentication/register.dart';

import '../global/global.dart';
import '../screens/home_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/error_dialog.dart';
import '../widgets/header_widget.dart';
import '../widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final double _headerHeight = 250;

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
          if (snapshot.data()!["status"] == "approved") {
            await sharedPreferences!.setString("uid", currentUser.uid);
            await sharedPreferences!
                .setString("email", snapshot.data()!["email"]);
            await sharedPreferences!
                .setString("name", snapshot.data()!["name"]);
            await sharedPreferences!
                .setString("photoUrl", snapshot.data()!["photoUrl"]);
            List<String> userCartList =
                snapshot.data()!["userCart"].cast<String>();
            await sharedPreferences!.setStringList("userCart", userCartList);

            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => const HomeScreen(),
              ),
            );
          } else {
            firebaseAuth.signOut();
            Navigator.pop(context);
            Fluttertoast.showToast(msg: "Your account has been blocked!");
          }
        }
        //if user is not a user
        else {
          firebaseAuth.signOut();
          Navigator.pop(context);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const LoginScreen(),
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
              SizedBox(
                height: _headerHeight,
                child: HeaderWidget(
                  _headerHeight,
                  true,
                  Icons.food_bank,
                ), //let's create a common header widget
              ),
              const SizedBox(height: 50),
              Center(
                child: Text(
                  'Login',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
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
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                        },
                        child: const Text(
                          "Forgot your password?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Container(
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                            'Sign In'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          formValidation();
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: 'Create',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterScreen()));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
