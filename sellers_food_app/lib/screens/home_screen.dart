import 'package:flutter/material.dart';
import 'package:sellers_food_app/global/global.dart';
import 'package:sellers_food_app/upload_screens/menus_upload_screen.dart';
import 'package:sellers_food_app/widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(3.0, -1.0),
              colors: [
                Color(0xFF004B8D),
                Color(0xFFffffff),
              ],
            ),
          ),
        ),
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: "Lobster",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => MenusUploadScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.post_add,
              color: Colors.orange,
            ),
          )
        ],
      ),
    );
  }
}
