import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sellers_food_app/authentication/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(
      const Duration(seconds: 8),
      () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => AuthScreen()));
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
              Image.asset('images/bg.png'),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Sellers App',
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
