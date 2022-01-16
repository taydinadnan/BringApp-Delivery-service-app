import 'package:flutter/material.dart';
import 'package:users_food_app/models/items.dart';

// ignore: must_be_immutable
class ItemsDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({Key? key, this.context, this.model}) : super(key: key);

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
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
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              )
            ],
          ),
        ),
      ),
    );
  }
}
