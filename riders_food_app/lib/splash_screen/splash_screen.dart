import 'dart:async';

import 'package:flutter/material.dart';

import '../authentication/auth_screen.dart';
import '../global/global.dart';
import '../screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(
      const Duration(seconds: 2),
      () async {
        //if the rider is already authenticate send user to home screen
        if (firebaseAuth.currentUser != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const HomeScreen(),
            ),
          );
        }
        //if not send to auth screen
        else {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const AuthScreen()));
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(2.0, 0.0),
            colors: [
              Color(0xFF004B8D),
              Color(0xFFffffff),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 200, child: Image.asset('images/logo2.png')),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Riders App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: "Signatra",
                    letterSpacing: 3,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
