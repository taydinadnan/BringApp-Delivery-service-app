import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:users_food_app/assistantMethods/address_changer.dart';
import 'package:users_food_app/maps/maps.dart';
import 'package:users_food_app/models/address.dart';
import 'package:users_food_app/screens/placed_order_screen.dart';

class AddressDesign extends StatefulWidget {
  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;

  const AddressDesign({
    Key? key,
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
  }) : super(key: key);

  @override
  _AddressDesignState createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(1, 2),
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            //sellect this address
            Provider.of<AddressChanger>(context, listen: false)
                .displayResult(widget.value);
          },
          child: Card(
            color: Colors.white.withOpacity(0.9),
            child: Column(
              children: [
                //address info
                Row(
                  children: [
                    Radio(
                      groupValue: widget.currentIndex!,
                      value: widget.value!,
                      activeColor: Colors.green,
                      onChanged: (val) {
                        //provider
                        Provider.of<AddressChanger>(context, listen: false)
                            .displayResult(val);
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  Text(
                                    "Name: ",
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.model!.name.toString(),
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Text(
                                    "Phone Number: ",
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.model!.phoneNumber.toString(),
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // TableRow(
                              //   children: [
                              //     Text(
                              //       "Flat Number: ",
                              //       style: GoogleFonts.lato(
                              //         textStyle: const TextStyle(
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.bold,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //     Text(
                              //       widget.model!.flatNumber.toString(),
                              //       style: GoogleFonts.lato(
                              //         textStyle: const TextStyle(
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.normal,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // TableRow(
                              //   children: [
                              //     Text(
                              //       "City: ",
                              //       style: GoogleFonts.lato(
                              //         textStyle: const TextStyle(
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.bold,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //     Text(
                              //       widget.model!.city.toString(),
                              //       style: GoogleFonts.lato(
                              //         textStyle: const TextStyle(
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.normal,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // TableRow(
                              //   children: [
                              //     Text(
                              //       "State: ",
                              //       style: GoogleFonts.lato(
                              //         textStyle: const TextStyle(
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.bold,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //     Text(
                              //       widget.model!.state.toString(),
                              //       style: GoogleFonts.lato(
                              //         textStyle: const TextStyle(
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.normal,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              TableRow(
                                children: [
                                  Text(
                                    "Full Address: ",
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.model!.fullAddress.toString(),
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                //check on maps
                ElevatedButton(
                  onPressed: () {
                    //check
                    MapsUtils.openMapWithPosition(
                        widget.model!.lat!, widget.model!.lng!);

                    // MapsUtils.openMapWithAddress(
                    //     widget.model!.fullAddress!);
                  },
                  child: const Text("Check on Maps"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                ),
                //button

                widget.value == Provider.of<AddressChanger>(context).count
                    ? ElevatedButton(
                        onPressed: () {
                          //check
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => PlacedOrderScreen(
                                addressID: widget.addressID,
                                totalAmount: widget.totalAmount,
                                sellerUID: widget.sellerUID,
                              ),
                            ),
                          );
                        },
                        child: const Text("Proceed"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
