import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global/global.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  double sellerTotalEarnings = 0;

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
              "Profile".toUpperCase(),
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/user.png",
                          height: 30,
                        ),
                        const SizedBox(width: 15),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Restaurants".toUpperCase(),
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Meals".toUpperCase(),
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
