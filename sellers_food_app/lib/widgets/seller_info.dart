import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sellers_food_app/global/global.dart';

class SellerInfo extends StatefulWidget {
  @override
  State<SellerInfo> createState() => _SellerInfoState();
}

class _SellerInfoState extends State<SellerInfo> {
  double sellerTotalEarnings = 0;

  retrieveSellerEarnings() async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap) {
      setState(() {
        sellerTotalEarnings = double.parse(snap.data()!["earnings"].toString());
      });
    });
  }

  @override
  void initState() {
    super.initState();

    retrieveSellerEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(-1.0, -7.0),
          end: FractionalOffset(5.0, -6.0),
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFAC898),
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Restaurant Info".toUpperCase(),
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(
                            "images/restaurant.png",
                            height: 30,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          sharedPreferences!.getString(
                            "name",
                          )!,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      sharedPreferences!.getString("email")!,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "Earnings: ",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "\$" + sellerTotalEarnings.toString(),
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Material(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(80),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: SizedBox(
                      height: 100,
                      width: 100,
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
            ],
          ),
          const Divider(
            thickness: 2,
            color: Colors.white,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  "images/menu.png",
                  height: 30,
                ),
              ),
              Text(
                "Menus",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
