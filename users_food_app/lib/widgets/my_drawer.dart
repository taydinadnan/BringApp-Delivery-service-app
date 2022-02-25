import 'package:flutter/material.dart';
import 'package:users_food_app/global/global.dart';
import 'package:users_food_app/screens/address_screen.dart';
import 'package:users_food_app/screens/history_screen.dart';
import 'package:users_food_app/screens/home_screen.dart';
import 'package:users_food_app/screens/my_orders_screen.dart';

import '../authentication/auth_screen.dart';

class MyDrawer extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

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
          ),

          const SizedBox(height: 12),

          //body drawer
          Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => HomeScreen()),
                      ),
                    );
                  },
                ),
                const Divider(height: 10, color: Colors.grey),
                ListTile(
                  leading: const Icon(
                    Icons.reorder,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'My Orders',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => MyOrdersScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 10, color: Colors.grey),
                ListTile(
                  leading: const Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'History',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => HistoryScreen()),
                      ),
                    );
                  },
                ),
                const Divider(height: 10, color: Colors.grey),
                ListTile(
                  leading: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {},
                ),
                const Divider(height: 10, color: Colors.grey),
                ListTile(
                  leading: const Icon(
                    Icons.add_location,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Add New Address',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => AddressScreen()),
                      ),
                    );
                  },
                ),
                const Divider(height: 10, color: Colors.grey),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    firebaseAuth.signOut().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => const AuthScreen(),
                        ),
                      );
                      _controller.clear();
                    });
                  },
                ),
                const Divider(height: 10, color: Colors.grey),
              ],
            ),
          )
        ],
      ),
    );
  }
}
