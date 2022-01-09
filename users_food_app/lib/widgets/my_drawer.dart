import 'package:flutter/material.dart';
import 'package:users_food_app/global/global.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //header drawer
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(80),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: SizedBox(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        //we get the profile image from sharedPreferences (global.dart)
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //we get the user name from sharedPreferences (global.dart)
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 20, fontFamily: "Acme"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
