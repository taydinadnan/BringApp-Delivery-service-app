import 'package:flutter/material.dart';

import '../splash_screen/splash_screen.dart';

class ShipmentScreen extends StatefulWidget {
  String? purchaserId;
  String? sellerId;
  String? getOrderID;
  String? purchaserAddress;
  double? purchaserLat;
  double? purchaserLng;

  ShipmentScreen({
    this.purchaserId,
    this.sellerId,
    this.getOrderID,
    this.purchaserAddress,
    this.purchaserLat,
    this.purchaserLng,
  });

  @override
  _ShipmentScreenState createState() => _ShipmentScreenState();
}

class _ShipmentScreenState extends State<ShipmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/confirm1.png",
            width: 350,
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              //TODO: show location from rider current location towards seller location
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/restaurant.png",
                  width: 50,
                ),
                const SizedBox(width: 7),
                Column(
                  children: const [
                    SizedBox(height: 12),
                    Text(
                      "Show Cafe/Restaurant Location",
                      style: TextStyle(
                        fontFamily: "Signatra",
                        fontSize: 20,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  //TODO: confirm that rider has picked order
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
                  width: MediaQuery.of(context).size.width - 90,
                  height: 50,
                  child: const Center(
                      child: Text(
                    "Confirmed",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
