import 'package:bringapp_admin_web_portal/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String adminEmail = "";
  String adminPassword = "";

  allowAdminToLogin() async {
    //1.display checking loading ...
    SnackBar snackBar = const SnackBar(
      content: Text(
        "Loading...",
        style: TextStyle(
          fontSize: 36,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.amber,
      duration: Duration(seconds: 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    //check email and password in firebaseauth
    User? currentAdmin;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: adminEmail,
      password: adminPassword,
    )
        .then((fAuth) {
      //success (asign admin to current admin)
      currentAdmin = fAuth.user;
    }).catchError(
      (onError) {
        //in case of error
        //display error message
        final snackBar = SnackBar(
          content: Text(
            "Error Occured: " + onError.toString(),
            style: const TextStyle(
              fontSize: 36,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.amber,
          duration: const Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );

//if admin info exists in firebase auth
    if (currentAdmin != null) {
      //check if that admin record exists in the collection in firestore database
      await FirebaseFirestore.instance
          .collection("admins")
          .doc(currentAdmin!.uid)
          .get()
          .then(
        (snap) {
          //if records exist send admin to homescreen
          if (snap.exists) {
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const HomeScreen()));
          } else {
            SnackBar snackBar = const SnackBar(
              content: Text(
                "No record found!" "\n" "You are not an Admin!",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.amber,
              duration: Duration(seconds: 4),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b232A),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //image
                    Image.asset("images/admin.png"),

                    //email text field
                    TextField(
                      onChanged: (value) {
                        adminEmail = value;
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orangeAccent,
                            width: 2,
                          ),
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white54),
                        icon: Icon(
                          Icons.email,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //password text field
                    TextField(
                      onChanged: (value) {
                        adminPassword = value;
                      },
                      obscureText: true,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orangeAccent,
                            width: 2,
                          ),
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white54),
                        icon: Icon(
                          Icons.admin_panel_settings_rounded,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //Login button
                    ElevatedButton(
                      onPressed: () {
                        allowAdminToLogin();
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontSize: 16,
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 20,
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepOrangeAccent,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.orangeAccent,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
