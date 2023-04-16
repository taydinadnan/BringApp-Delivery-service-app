import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:users_food_app/assistantMethods/address_changer.dart';
import 'package:users_food_app/screens/save_address_screen.dart';
import 'package:users_food_app/widgets/design/address_design.dart';
import 'package:users_food_app/widgets/progress_bar.dart';
import 'package:users_food_app/widgets/simple_app_bar.dart';

import '../global/global.dart';
import '../models/address.dart';

class AddressScreen extends StatefulWidget {
  final double? totalAmount;
  final String? sellerUID;

  const AddressScreen({
    Key? key,
    this.sellerUID,
    this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Address",
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Add New Address",
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.amber,
        icon: const Icon(
          Icons.add_location,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((c) => SaveAddressScreen()),
            ),
          );
        },
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(-1.0, 0.0),
            end: FractionalOffset(4.0, -1.0),
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFAC898),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Select Address:",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Consumer<AddressChanger>(
              builder: (context, address, c) {
                return Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(sharedPreferences!.getString("uid"))
                        .collection("userAddress")
                        .snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? Center(
                              child: circularProgress(),
                            )
                          : snapshot.data!.docs.isEmpty
                              ? Container()
                              : ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return AddressDesign(
                                      currentIndex: address.count,
                                      value: index,
                                      addressID: snapshot.data!.docs[index].id,
                                      totalAmount: widget.totalAmount,
                                      sellerUID: widget.sellerUID,
                                      model: Address.fromJson(
                                          snapshot.data!.docs[index].data()!
                                              as Map<String, dynamic>),
                                    );
                                  },
                                );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
