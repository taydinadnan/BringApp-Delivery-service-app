import 'package:flutter/material.dart';
import 'package:users_food_app/widgets/simple_app_bar.dart';
import 'package:users_food_app/widgets/text_field.dart';

class SaveAddressScreen extends StatelessWidget {
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _flatNumber = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _completeAddress = TextEditingController();
  final _locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Save"),
        icon: const Icon(
          Icons.check,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 6),
            const Align(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Save New Address: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person_pin_circle,
                color: Colors.red,
                size: 35,
              ),
              title: Container(
                width: 250,
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: _locationController,
                  decoration: const InputDecoration(
                    hintText: "What's your Address?",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              label: const Text(
                "Get my Address",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.orangeAccent),
                  ),
                ),
              ),
              onPressed: () {
                //get current location
              },
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  MyTextField(
                    hint: "Name",
                    controller: _name,
                  ),
                  MyTextField(
                    hint: "Phone Number",
                    controller: _phoneNumber,
                  ),
                  MyTextField(
                    hint: "City",
                    controller: _city,
                  ),
                  MyTextField(
                    hint: "State / Country",
                    controller: _state,
                  ),
                  MyTextField(
                    hint: "Address Line",
                    controller: _flatNumber,
                  ),
                  MyTextField(
                    hint: "Complete Address",
                    controller: _completeAddress,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
