import 'package:flutter/material.dart';
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
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: InkWell(
        splashColor: Colors.orange,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Image.network(
                  widget.model!.thumbnailUrl!,
                  height: 210,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 1),
                Text(
                  widget.model!.menuTitle!,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontFamily: "Acme",
                  ),
                ),
                Text(
                  widget.model!.menuInfo!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: "Acme",
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
      ),
    );
  }
}
