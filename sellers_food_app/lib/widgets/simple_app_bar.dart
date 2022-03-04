import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  String? title;
  SimpleAppBar({this.bottom, this.title});

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
        "Item Details",
        style: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(
        color: Colors.black,
        size: 35,
      ),
    );
  }
}
