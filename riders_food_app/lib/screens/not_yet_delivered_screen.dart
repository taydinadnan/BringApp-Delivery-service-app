import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riders_food_app/global/global.dart';

import '../assistantMethods/assistant_methods.dart';
import '../widgets/order_card_design.dart';
import '../widgets/progress_bar.dart';
import '../widgets/simple_app_bar.dart';

class NotYetDeliveredScreen extends StatefulWidget {
  const NotYetDeliveredScreen({Key? key}) : super(key: key);

  @override
  _NotYetDeliveredScreenState createState() => _NotYetDeliveredScreenState();
}

class _NotYetDeliveredScreenState extends State<NotYetDeliveredScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SimpleAppBar(
          title: "Not Yet Delivered",
        ),
      ),
      body: Container(
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("riderUID", isEqualTo: sharedPreferences!.getString("uid"))
              .where("status", isEqualTo: "delivering")
              .snapshots(),
          builder: (c, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (c, index) {
                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("items")
                            .where("itemID",
                                whereIn: separateOrderItemIDs(
                                    (snapshot.data!.docs[index].data()!
                                        as Map<String, dynamic>)["productIDs"]))
                            .orderBy("publishedDate", descending: true)
                            .get(),
                        builder: (c, snap) {
                          return snap.hasData
                              ? OrderCard(
                                  itemCount: snap.data!.docs.length,
                                  data: snap.data!.docs,
                                  orderID: snapshot.data!.docs[index].id,
                                  seperateQuantitiesList:
                                      separateOrderItemQuantities(
                                          (snapshot.data!.docs[index].data()!
                                                  as Map<String, dynamic>)[
                                              "productIDs"]),
                                )
                              : Center(child: circularProgress());
                        },
                      );
                    },
                  )
                : Center(
                    child: circularProgress(),
                  );
          },
        ),
      ),
    );
  }
}
