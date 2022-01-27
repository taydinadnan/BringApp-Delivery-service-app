import 'package:flutter/material.dart';
import 'package:users_food_app/screens/save_address_screen.dart';
import 'package:users_food_app/widgets/simple_app_bar.dart';

class AddressScreen extends StatefulWidget {
  final double? totalAmount;
  final String? sellerUID;

  AddressScreen({
    this.sellerUID,
    this.totalAmount,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add New Address"),
        backgroundColor: Colors.orangeAccent,
        icon: const Icon(
          Icons.add_location,
          color: Colors.red,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Select Address:",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
