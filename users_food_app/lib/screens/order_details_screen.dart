import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:users_food_app/models/address.dart';
import 'package:users_food_app/widgets/design/shipment_address_design.dart';
import 'package:users_food_app/widgets/progress_bar.dart';
import 'package:users_food_app/widgets/status_banner.dart';

import '../global/global.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String? orderID;

  const OrderDetailsScreen({Key? key, this.orderID}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderStatus = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("orders")
                .doc(widget.orderID)
                .get(),
            builder: (c, snapshot) {
              Map? dataMap;
              if (snapshot.hasData) {
                dataMap = snapshot.data!.data()! as Map<String, dynamic>;
                orderStatus = dataMap["status"].toString();
              }
              return snapshot.hasData
                  ? Column(
                      children: [
                        StatusBanner(
                          status: dataMap!["isSuccess"],
                          orderStatus: orderStatus,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Total Amount: " "\$ " +
                                  dataMap["totalAmount"].toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Order ID: " + widget.orderID!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DateFormat("dd MMMM yy \n     hh:mm aa").format(
                              DateTime.fromMillisecondsSinceEpoch(
                                int.parse(dataMap["orderTime"]),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const Divider(thickness: 4),
                        orderStatus == "ended"
                            ? Image.asset("images/delivered.jpg")
                            : Image.asset("images/state.jpg"),
                        const Divider(thickness: 4),
                        FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection("users")
                              .doc(sharedPreferences!.getString("uid"))
                              .collection("userAddress")
                              .doc(dataMap["addressID"])
                              .get(),
                          builder: (c, snapshot) {
                            return snapshot.hasData
                                ? ShipmentAddressDesign(
                                    model: Address.fromJson(snapshot.data!
                                        .data()! as Map<String, dynamic>),
                                  )
                                : Center(
                                    child: circularProgress(),
                                  );
                          },
                        )
                      ],
                    )
                  : Center(
                      child: circularProgress(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
