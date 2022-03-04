import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sellers_food_app/models/items.dart';
import 'package:sellers_food_app/screens/item_detail_screen.dart';

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
                  widget.model!.title!,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.model!.shortInfo!,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
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
              builder: (c) => ItemDetailsScreen(model: widget.model),
            ),
          );
        });
    //   ),
    // );
  }
}
