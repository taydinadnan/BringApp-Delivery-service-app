import 'package:bringapp_admin_web_portal/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String adminEmail = "";
  String adminPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b232A),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomeScreen())));
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
