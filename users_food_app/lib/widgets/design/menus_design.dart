import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_food_app/models/menus.dart';
import 'package:users_food_app/screens/items_screen.dart';

class MenusDesignWidget extends StatefulWidget {
  Menus? model;
  BuildContext? context;

  MenusDesignWidget({this.context, this.model});

  @override
  _MenusDesignWidgetState createState() => _MenusDesignWidgetState();
}

class _MenusDesignWidgetState extends State<MenusDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 260,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 1),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.model!.thumbnailUrl!,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.model!.menuTitle!,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
              Text(
                widget.model!.menuInfo!,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => ItemsScreen(model: widget.model),
          ),
        );
      },
    );
  }
}
