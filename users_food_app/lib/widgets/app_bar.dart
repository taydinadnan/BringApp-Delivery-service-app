import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:users_food_app/assistantMethods/cart_item_counter.dart';
import 'package:users_food_app/screens/cart_screen.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  final String? sellerUID;
  MyAppBar({this.bottom, this.sellerUID});

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => CartScreen(sellerUID: widget.sellerUID),
                  ),
                );
              },
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
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
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
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      automaticallyImplyLeading: true,
      elevation: 0,
    );
  }
}
