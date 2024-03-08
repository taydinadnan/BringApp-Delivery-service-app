import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SimpleAppBar extends StatelessWidget {
  final PreferredSizeWidget? bottom;
  String? title;
  SimpleAppBar({Key? key, this.bottom, this.title}) : super(key: key);

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
            begin: FractionalOffset(-1.0, 0.0),
            end: FractionalOffset(4.0, -1.0),
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFAC898),
            ],
          ),
        ),
      ),
      title: Text(
        title!,
        style: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    );
  }
}
