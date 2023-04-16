import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/items.dart';
import '../screens/order_details_screen.dart';

class OrderCard extends StatelessWidget {
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  const OrderCard({
    Key? key,
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => OrderDetailsScreen(orderID: orderID)),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(8),
        height: itemCount! * 100,
        child: ListView.builder(
          itemCount: itemCount,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Items model =
                Items.fromJson(data![index].data()! as Map<String, dynamic>);
            return placedOrderDesignWidget(
                model, context, seperateQuantitiesList![index]);
          },
        ),
      ),
    );
  }
}

Widget placedOrderDesignWidget(
    Items model, BuildContext context, seperateQuantitiesList) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 3,
          offset: Offset(2, 2),
        ),
      ],
    ),
    width: MediaQuery.of(context).size.width,
    height: 80,
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            model.thumbnailUrl!,
            width: 120,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      model.title!,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "\$ ",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Text(
                    model.price.toString() + "   ",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              //total number
              Row(
                children: [
                  Text(
                    "x ",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      seperateQuantitiesList,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}
