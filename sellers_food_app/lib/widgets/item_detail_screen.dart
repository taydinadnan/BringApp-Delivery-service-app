import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sellers_food_app/global/global.dart';
import 'package:sellers_food_app/splash_screen/splash_screen.dart';
import 'package:sellers_food_app/widgets/simple_app_bar.dart';
import '../models/items.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();

  deleteItem(String itemID) {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.menuID)
        .collection("items")
        .doc(itemID)
        .delete()
        .then(
      (value) {
        FirebaseFirestore.instance.collection("items").doc(itemID).delete();

        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const SplashScreen())));

        Fluttertoast.showToast(msg: "Item Deleted");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: sharedPreferences!.getString("name"),
      ),
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
                //delete item
                deleteItem(widget.model!.itemID!);
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
                    "Delete item.",
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
