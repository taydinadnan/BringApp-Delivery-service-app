import 'package:flutter/material.dart';
import 'package:riders_food_app/global/global.dart';
import 'package:riders_food_app/splash_screen/splash_screen.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAC898),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$" + previousRiderEarnings,
                style: const TextStyle(
                  fontSize: 80,
                  color: Colors.black,
                  fontFamily: "Signatra",
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Total Earnings ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                  thickness: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const SplashScreen())));
                },
                child: const Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 140,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Back",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
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
