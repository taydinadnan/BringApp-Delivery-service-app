import 'package:flutter/material.dart';
import 'package:sellers_food_app/models/items.dart';
import 'package:sellers_food_app/widgets/item_detail_screen.dart';

// ignore: must_be_immutable
class ItemsDesign extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ItemsDesign({Key? key, this.context, this.model}) : super(key: key);

  @override
  _ItemsDesignState createState() => _ItemsDesignState();
}

class _ItemsDesignState extends State<ItemsDesign> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
        child: InkWell(
            splashColor: Colors.orange,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: SizedBox(
                height: 280,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(height: 1),
                    Text(
                      widget.model!.title!,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontFamily: "Acme",
                      ),
                    ),
                    Image.network(
                      widget.model!.thumbnailUrl!,
                      height: 210,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 5),
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => ItemDetailsScreen(model: widget.model),
                ),
              );
            }),
      ),
    );
  }
}
