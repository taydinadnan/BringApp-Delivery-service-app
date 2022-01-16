import 'package:flutter/material.dart';
import 'package:users_food_app/models/menus.dart';
import 'package:users_food_app/screens/items_screen.dart';

// ignore: must_be_immutable
class MenusDesignWidget extends StatefulWidget {
  Menus? model;
  BuildContext? context;

  MenusDesignWidget({Key? key, this.context, this.model}) : super(key: key);

  @override
  _MenusDesignWidgetState createState() => _MenusDesignWidgetState();
}

class _MenusDesignWidgetState extends State<MenusDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: SizedBox(
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
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
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              )
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
