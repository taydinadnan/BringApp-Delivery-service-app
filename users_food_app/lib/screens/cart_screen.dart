import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:users_food_app/assistantMethods/assistant_methods.dart';
import 'package:users_food_app/assistantMethods/total_amount.dart';
import 'package:users_food_app/splash_screen/splash_screen.dart';
import 'package:users_food_app/widgets/design/cart_item_design.dart';
import 'package:users_food_app/widgets/progress_bar.dart';

import '../assistantMethods/cart_item_counter.dart';
import '../assistantMethods/total_amount.dart';
import '../models/items.dart';
import '../widgets/text_widget_header.dart';
import 'address_screen.dart';

class CartScreen extends StatefulWidget {
  final String? sellerUID;

  CartScreen({this.sellerUID});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? separateItemQuantityList;

  num totalAmount = 0;

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(0);

    separateItemQuantityList = separateItemQuantities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(-2.0, 0.0),
              end: FractionalOffset(5.0, -1.0),
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFAC898),
              ],
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.orange,
                ),
              ),
              Positioned(
                child: Stack(
                  children: [
                    const Icon(
                      Icons.brightness_1,
                      size: 20,
                      color: Colors.green,
                    ),
                    Positioned(
                      top: 3,
                      right: 4,
                      child: Center(
                        child: Consumer<CartItemCounter>(
                            builder: (context, counter, c) {
                          return Text(
                            counter.count.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.clear_all),
          onPressed: () {
            clearCartNow(context);
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: 10,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn1",
              label: const Text(
                "Clear Cart",
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.amber,
              icon: const Icon(Icons.clear_all),
              onPressed: () {
                clearCartNow(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const SplashScreen()));

                Fluttertoast.showToast(msg: "Cart has been cleared.");
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn2",
              label: const Text(
                "Check Out",
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.amber,
              icon: const Icon(Icons.navigate_next),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => AddressScreen(
                      totalAmount: totalAmount.toDouble(),
                      sellerUID: widget.sellerUID,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(-1.0, 0.0),
            end: FractionalOffset(2.0, -1.0),
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFAC898),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            //overall total price
            SliverPersistentHeader(
              pinned: true,
              delegate: TextWidgetHeader(title: "My Cart List"),
            ),

            SliverToBoxAdapter(
              child: Consumer2<TotalAmount, CartItemCounter>(
                  builder: (context, amountProvider, cartProvider, c) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: cartProvider.count == 0
                        ? Container()
                        : Text(
                            "Total Price: ${"\$" + amountProvider.tAmount.toString()}",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                  ),
                );
              }),
            ),

            //display cart items with quantity numbers
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("items")
                  .where("itemID", whereIn: separateItemIDs())
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    //if length = 0 no data
                    // : snapshot.data!.docs.length == 0
                    //     ? Container()
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            Items model = Items.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>,
                            );

                            //calculating total price in cart list
                            if (index == 0) {
                              totalAmount = 0;
                              totalAmount = totalAmount +
                                  (model.price! *
                                      separateItemQuantityList![index]);
                            } else {
                              totalAmount = totalAmount +
                                  (model.price! *
                                      separateItemQuantityList![index]);
                            }
                            //update in real time
                            if (snapshot.data!.docs.length - 1 == index) {
                              WidgetsBinding.instance!.addPostFrameCallback(
                                (timeStamp) {
                                  Provider.of<TotalAmount>(context,
                                          listen: false)
                                      .displayTotalAmount(
                                          totalAmount.toDouble());
                                },
                              );
                            }

                            return CartItemDesign(
                              model: model,
                              context: context,
                              quanNumber: separateItemQuantityList![index],
                            );
                          },
                          childCount:
                              snapshot.hasData ? snapshot.data!.docs.length : 0,
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
