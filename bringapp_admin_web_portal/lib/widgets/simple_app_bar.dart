// ignore_for_file: must_be_immutable

import 'package:bringapp_admin_web_portal/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  String? title;
  SimpleAppBar({super.key, this.bottom, this.title});

  @override
  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
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
      leading: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const HomeScreen()),
            ),
          );
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Text(
        title!,
        style: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: true,
    );
  }
}
