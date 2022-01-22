import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:users_food_app/widgets/app_bar.dart';

import '../assistantMethods/assistant_methods.dart';
import '../models/items.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Image.network(
              widget.model!.thumbnailUrl.toString(),
            ),
          ),

          //food items increment , decrement counter
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
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
                width: 150,
                child: NumberInputWithIncrementDecrement(
                  controller: counterTextEditingController,
                  numberFieldDecoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  widgetContainerDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.orange,
                      width: 2,
                    ),
                  ),
                  incIconDecoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  separateIcons: true,
                  decIconDecoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  incIconSize: 25,
                  decIconSize: 25,
                  incIcon: Icons.plus_one,
                  decIcon: Icons.exposure_neg_1,
                  max: 9,
                  min: 1,
                  initialValue: 1,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "\$" + widget.model!.price.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Center(
            child: InkWell(
              onTap: () {
                int itemCounter = int.parse(counterTextEditingController.text);
                //1.check if item exist already in cart

                // add to cart
                addItemToCart(
                  widget.model!.itemID,
                  context,
                  itemCounter,
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(3.0, -1.0),
                    colors: [
                      Color(0xFF004B8D),
                      Color(0xFFffffff),
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                width: MediaQuery.of(context).size.width - 13,
                height: 50,
                child: const Center(
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
