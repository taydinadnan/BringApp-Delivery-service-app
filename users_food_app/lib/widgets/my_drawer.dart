import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_food_app/authentication/login.dart';
import 'package:users_food_app/global/global.dart';
import 'package:users_food_app/screens/address_screen.dart';
import 'package:users_food_app/screens/history_screen.dart';
import 'package:users_food_app/screens/home_screen.dart';
import 'package:users_food_app/screens/my_orders_screen.dart';
import 'package:users_food_app/screens/search_screen.dart';

class MyDrawer extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
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
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.4),
                                offset: const Offset(-1, 10),
                                blurRadius: 10,
                              )
                            ],
                          ),
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
                  const SizedBox(height: 10),
                  //we get the user name from sharedPreferences (global.dart)
                  Text(
                    sharedPreferences!.getString("name")!,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                  const Divider(height: 10, color: Colors.white, thickness: 2),
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'Home',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const HomeScreen()),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 10, color: Colors.white, thickness: 2),
                  ListTile(
                    leading: const Icon(
                      Icons.reorder,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'My Orders',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => const MyOrdersScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 10, color: Colors.white, thickness: 2),
                  ListTile(
                    leading: const Icon(
                      Icons.access_time,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'History',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const HistoryScreen()),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 10, color: Colors.white, thickness: 2),
                  ListTile(
                    leading: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'Search',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const SearchScreen()),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 10, color: Colors.white, thickness: 2),
                  ListTile(
                    leading: const Icon(
                      Icons.add_location,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'Add New Address',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const AddressScreen()),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 10, color: Colors.white, thickness: 2),
                  ListTile(
                    leading: const Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'Sign Out',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      firebaseAuth.signOut().then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const LoginScreen(),
                          ),
                        );
                        _controller.clear();
                      });
                    },
                  ),
                  const Divider(height: 10, color: Colors.white, thickness: 2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
