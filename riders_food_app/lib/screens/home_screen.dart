// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riders_food_app/assistantMethods/get_current_location.dart';
import 'package:riders_food_app/authentication/login.dart';
import 'package:riders_food_app/screens/earnings_screen.dart';
import 'package:riders_food_app/screens/history_screen.dart';
import 'package:riders_food_app/screens/new_orders_screen.dart';
import 'package:riders_food_app/screens/not_yet_delivered_screen.dart';
import 'package:riders_food_app/screens/parcel_in_progress_screen.dart';

import '../global/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  Card makeDashboardItem(String title, IconData iconData, int index) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(1.0, -1.0),
                  end: FractionalOffset(-1.0, -1.0),
                  colors: [
                    Colors.amber,
                    Colors.orangeAccent,
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                    offset: Offset(4, 3),
                  )
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(-1.0, 0.0),
                  end: FractionalOffset(5.0, -1.0),
                  colors: [
                    Colors.orangeAccent,
                    Colors.amber,
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                    offset: Offset(4, 3),
                  )
                ],
              ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              //new orders
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const NewOrdersScreen())));
            }
            if (index == 1) {
              //Parcels in progress
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ParcelInProgressScreen()));
            }
            if (index == 2) {
              //not yet delivered
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotYetDeliveredScreen()));
            }
            if (index == 3) {
              //history
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HistoryScreen()));
            }
            if (index == 4) {
              //total earnings
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EarningsScreen()));
            }
            if (index == 5) {
              //logout
              firebaseAuth.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const LoginScreen())));
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Icon(
                  iconData,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    UserLocation uLocation = UserLocation();
    uLocation.getCurrenLocation();
    getPerParcelDeliveryAmount();
    getRiderPreviousEarnings();
  }

  getRiderPreviousEarnings() {
    FirebaseFirestore.instance
        .collection("riders")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap) {
      previousRiderEarnings = snap.data()!["earnings"].toString();
    });
  }

  //method to calculate amount per delivery
  getPerParcelDeliveryAmount() {
    FirebaseFirestore.instance
        .collection("perDelivery")
        .doc("taydinadnan")
        .get()
        .then((snap) {
      perParcelDeliveryAmount = snap.data()!["amount"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: Text(
          "Welcome " + sharedPreferences!.getString("name")!.toUpperCase(),
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Material(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(80),
                  ),
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(1),
                          offset: const Offset(-1, 2),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    width: 60,
                    height: 60,
                    child: CircleAvatar(
                      //we get the profile image from sharedPreferences (global.dart)
                      backgroundImage: NetworkImage(
                        sharedPreferences!.getString("photoUrl")!,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
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
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 1),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(2),
          children: [
            makeDashboardItem("New Available", Icons.assignment, 0),
            makeDashboardItem("Parcels in Progress", Icons.airport_shuttle, 1),
            makeDashboardItem("Not Yet Delivered", Icons.location_history, 2),
            makeDashboardItem("History", Icons.done_all, 3),
            makeDashboardItem("Total Earnings", Icons.monetization_on, 4),
            makeDashboardItem("Logout", Icons.logout, 5),
          ],
        ),
      ),
    );
  }
}
