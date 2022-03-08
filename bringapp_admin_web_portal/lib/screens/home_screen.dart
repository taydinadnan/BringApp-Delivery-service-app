import 'dart:async';

import 'package:bringapp_admin_web_portal/authentication/login_screen.dart';
import 'package:bringapp_admin_web_portal/riders/activate_riders_screen.dart';
import 'package:bringapp_admin_web_portal/riders/deactivate_riders_screen.dart';
import 'package:bringapp_admin_web_portal/sellers/deactivate_sellers_screen.dart';
import 'package:bringapp_admin_web_portal/users/active_users_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../sellers/activate_sellers_screen.dart';
import '../users/deactivate_users_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String timeText = '';
  String dateText = '';

  //getting time
  String formatCurrentLiveTime(DateTime time) {
    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentDate(DateTime date) {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime() {
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentDate(timeNow);

    if (this.mounted) {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //time
    timeText = formatCurrentLiveTime(DateTime.now());
    //date
    dateText = formatCurrentDate(DateTime.now());

    //seconds
    Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentLiveTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b232A),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff1b232A),
                Colors.white,
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(6, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text(
          "Admin Web Portal",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          dateText,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            letterSpacing: 2,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          timeText,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // user activate and deactivate accounts ui
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //activate user
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const ActiveUsersScreen()),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.person_add,
                      color: Color.fromARGB(255, 117, 190, 119),
                    ),
                    label: Text(
                      "All Active".toUpperCase() +
                          "\n  " +
                          "Users".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(30),
                        primary: Colors.amber),
                  ),
                  const SizedBox(width: 10),
                  //deactivate user
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const DeactiveUsersScreen()),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.block_flipped,
                      color: Colors.redAccent,
                    ),
                    label: Text(
                      "Deactivate".toUpperCase() +
                          "\n    " +
                          "Users".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(30),
                        primary: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 20),

              //sellers activate and deactivate account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //activate seller
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const ActiveSellersScreen()),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.person_add,
                      color: Color.fromARGB(255, 117, 190, 119),
                    ),
                    label: Text(
                      "All Active".toUpperCase() +
                          "\n " +
                          "Sellers".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(30),
                        primary: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  //deactivate user
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const DeactiveSellersScreen()),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.block,
                      color: Colors.redAccent,
                    ),
                    label: Text(
                      "Deactivate".toUpperCase() +
                          "\n    " +
                          "Sellers".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(30),
                        primary: Colors.amber),
                  )
                ],
              ),

              const SizedBox(height: 20),

              //riders activate and deactivate account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //activate seller
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => ActiveRidersScreen()),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.person_add,
                      color: Color.fromARGB(255, 117, 190, 119),
                    ),
                    label: Text(
                      "All Active".toUpperCase() +
                          "\n   " +
                          "Riders".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(30),
                        primary: Colors.amber),
                  ),
                  const SizedBox(width: 10),
                  //deactivate user
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => DeactiveRidersScreen()),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.block,
                      color: Colors.redAccent,
                    ),
                    label: Text(
                      "Deactivate".toUpperCase() +
                          "\n   " +
                          "Riders".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(30),
                        primary: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 50),

              //Logout
              ElevatedButton.icon(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => LoginScreen())));
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.grey,
                ),
                label: Text(
                  "Logout".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    letterSpacing: 3,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(30), primary: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
