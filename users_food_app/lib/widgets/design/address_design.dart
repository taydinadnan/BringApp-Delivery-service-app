import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_food_app/assistantMethods/address_changer.dart';
import 'package:users_food_app/models/address.dart';

class AddressDesign extends StatefulWidget {
  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;

  AddressDesign({
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
  });

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
        margin: const EdgeInsets.symmetric(horizontal: 1),
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
        child: InkWell(
          onTap: () {
            //sellect this address
            Provider.of<AddressChanger>(context, listen: false)
                .displayResult(widget.value);
          },
          child: Card(
            color: Colors.blueGrey.withOpacity(0.4),
            child: Column(
              children: [
                //address info
                Row(
                  children: [
                    Radio(
                      groupValue: widget.currentIndex!,
                      value: widget.value!,
                      activeColor: Colors.orangeAccent,
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
                                  const Text(
                                    "Name: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.model!.name.toString(),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text(
                                    "Phone Number: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.model!.phoneNumber.toString(),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text(
                                    "Flat Number: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.model!.flatNumber.toString(),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text(
                                    "City: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.model!.city.toString(),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text(
                                    "State: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.model!.state.toString(),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text(
                                    "Full Address: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.model!.fullAddress.toString(),
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
                  },
                  child: const Text("Check on Maps"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black54,
                  ),
                ),
                //button

                widget.value == Provider.of<AddressChanger>(context).count
                    ? ElevatedButton(
                        onPressed: () {
                          //check
                        },
                        child: const Text("Proceed"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
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
