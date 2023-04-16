import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import '../assistantMethods/assistant_methods.dart';
import '../models/items.dart';
import '../widgets/app_bar.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Items? model;
  const ItemDetailsScreen({Key? key, this.model}) : super(key: key);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                color: Colors.white,
                height: 250,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                              gradient: LinearGradient(
                                begin: FractionalOffset(1.0, 1.0),
                                end: FractionalOffset(1.0, 1.0),
                                colors: [
                                  Color(0xFFFFFFFF),
                                  Color(0xFFFAC898),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(-1, 10),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.network(
                            widget.model!.thumbnailUrl.toString(),
                            height: 300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: const Color(0xFFFAC898),
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.amber,
                                width: 2,
                              ),
                            ),
                            incIconDecoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            separateIcons: true,
                            decIconDecoration: const BoxDecoration(
                              color: Colors.amber,
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
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description: ",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.model!.longDescription.toString(),
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Price: ",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "\$" + widget.model!.price.toString(),
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Center(
                      child: InkWell(
                        onTap: () {
                          int itemCounter =
                              int.parse(counterTextEditingController.text);
                          List<String> separateItemIDsList = separateItemIDs();
                          //1.check if item exist already in cart
                          separateItemIDsList.contains(widget.model!.itemID)
                              ? Fluttertoast.showToast(
                                  msg: "Item is already in Cart")
                              //2.if not add item to cart
                              : addItemToCart(
                                  widget.model!.itemID, context, itemCounter);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 4),
                                    blurRadius: 5.0)
                              ],
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0.0, 1.0],
                                colors: [
                                  Colors.amber,
                                  Colors.black,
                                ],
                              ),
                              color: Colors.deepPurple.shade300,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                'Add to Cart'.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
