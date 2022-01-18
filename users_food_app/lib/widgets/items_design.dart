import 'package:flutter/material.dart';
import 'package:users_food_app/models/items.dart';

// ignore: must_be_immutable
class ItemsDesignWidget extends StatefulWidget {
  Items? model;

  ItemsDesignWidget({this.model});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.orange,
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: SizedBox(
            height: 280,
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
                  widget.model!.title!,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontFamily: "Acme",
                  ),
                ),
                Text(
                  widget.model!.shortInfo!,
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
      ),
    );
  }
}
