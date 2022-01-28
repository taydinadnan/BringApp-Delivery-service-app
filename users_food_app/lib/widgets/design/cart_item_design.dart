import 'package:flutter/material.dart';
import 'package:users_food_app/models/items.dart';

class CartItemDesign extends StatefulWidget {
  final Items? model;
  BuildContext? context;
  final int? quanNumber;

  CartItemDesign({
    this.model,
    this.context,
    this.quanNumber,
  });

  @override
  _CartItemDesignState createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.orangeAccent,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
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
            child: Row(
              children: [
                //1.image
                Image.network(
                  widget.model!.thumbnailUrl!,
                  width: 140,
                  height: 120,
                ),
                const SizedBox(width: 6),
                // column for tittle and quantity number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //2.title
                    Text(
                      widget.model!.title!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Kiwi",
                      ),
                    ),
                    const SizedBox(height: 1),
                    //3.quantity number
                    Row(
                      children: [
                        const Text(
                          "x ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: "Acme",
                          ),
                        ),
                        Text(
                          widget.quanNumber.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: "Acme",
                          ),
                        ),
                      ],
                    ),

                    //price Row
                    Row(
                      children: [
                        const Text(
                          "Price ",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const Text(
                          "\$",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.model!.price.toString(),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
