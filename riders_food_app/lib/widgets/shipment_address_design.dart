import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riders_food_app/assistantMethods/get_current_location.dart';
import 'package:riders_food_app/screens/parcel_picking_screen.dart';

import '../global/global.dart';
import '../models/address.dart';
import '../splash_screen/splash_screen.dart';

class ShipmentAddressDesign extends StatelessWidget {
  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;

  const ShipmentAddressDesign({
    Key? key,
    this.model,
    this.orderStatus,
    this.orderId,
    this.sellerId,
    this.orderByUser,
  }) : super(key: key);

  confirmedParcelShipment(BuildContext context, String getOrderID,
      String sellerId, String purchaserId) {
    FirebaseFirestore.instance.collection("orders").doc(getOrderID).update(
      {
        "riderUID": sharedPreferences!.getString("uid"),
        "riderName": sharedPreferences!.getString("name"),
        "status": "picking",
        "lat": position!.latitude,
        "lng": position!.longitude,
        "address": completeAddress,
      },
    );

    // send rider to shipment screen

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => ParcelPickingScreen(
              purchaserId: purchaserId,
              purchaserAddress: model!.fullAddress,
              purchaserLat: model!.lat,
              purchaserLng: model!.lng,
              sellerId: sellerId,
              getOrderID: getOrderID,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Shipping Details: ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                  const Text(
                    "-Name",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(model!.name!),
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    "-Phone Number",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(model!.phoneNumber!),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.fullAddress!,
            textAlign: TextAlign.justify,
          ),
        ),
        orderStatus == "ended"
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      UserLocation uLocation = UserLocation();
                      uLocation.getCurrenLocation();

                      confirmedParcelShipment(
                        context,
                        orderId!,
                        sellerId!,
                        orderByUser!,
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
                      ),
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      child: const Center(
                          child: Text(
                        "Confirm - To Deliver this Parcel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )),
                    ),
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const SplashScreen()),
                  ),
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
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                    child: Text(
                  "Go back",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
