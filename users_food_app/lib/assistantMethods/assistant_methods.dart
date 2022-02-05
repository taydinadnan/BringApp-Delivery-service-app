import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:users_food_app/assistantMethods/cart_item_counter.dart';
import 'package:users_food_app/global/global.dart';

//productIDs
separateOrdesItemIDs(orderIDs) {
  List<String> separateItemIDsList = [], defaultItemList = [];
  int i = 0;

  defaultItemList = List<String>.from(orderIDs);

  for (i; i < defaultItemList.length; i++) {
    //this format => 34567654:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

    //to this format => 34567654
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    separateItemIDsList.add(getItemId);
  }

  return separateItemIDsList;
}

//returns items id(specific keys without quantity)
separateItemIDs() {
  List<String> separateItemIDsList = [], defaultItemList = [];
  int i = 0;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for (i; i < defaultItemList.length; i++) {
    //this format => 34567654:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

    //to this format => 34567654
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    separateItemIDsList.add(getItemId);
  }

  return separateItemIDsList;
}

separateOrderItemQuantities(orderIDs) {
  List<String> separateItemQuantityList = [];
  List<String> defaultItemList = [];
  int i = 1;

  defaultItemList = List<String>.from(orderIDs);

  for (i; i < defaultItemList.length; i++) {
    //this format => 34567654:7
    String item = defaultItemList[i].toString();

    //to this format => 7
    List<String> listItemCharacters = item.split(":").toList();

    //converting to int
    var quanNumber = int.parse(listItemCharacters[1].toString());

    separateItemQuantityList.add(quanNumber.toString());
  }

  return separateItemQuantityList;
}

//returns items quantity without item id(specific keys)
separateItemQuantities() {
  List<int> separateItemQuantityList = [];
  List<String> defaultItemList = [];
  int i = 1;

//get cart list and sing it
  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for (i; i < defaultItemList.length; i++) {
    //this format => 34567654:7
    String item = defaultItemList[i].toString();

    //to this format => 7
    List<String> listItemCharacters = item.split(":").toList();

    //converting to int
    var quanNumber = int.parse(listItemCharacters[1].toString());

    separateItemQuantityList.add(quanNumber);
  }

  return separateItemQuantityList;
}

//item count
addItemToCart(String? foodItemId, BuildContext context, int itemCounter) {
  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId! + ":$itemCounter"); //this format = 34567654:7

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update(
    {
      "userCart": tempList,
    },
  ).then(
    (value) {
      Fluttertoast.showToast(msg: "Item Added Successfully");

      sharedPreferences!.setStringList("userCart", tempList);

      //update the badge
      Provider.of<CartItemCounter>(context, listen: false)
          .displayCartListItemsNumber();
    },
  );
}

//Clear Cart
clearCartNow(context) {
  sharedPreferences!.setStringList("userCart", ['garbageValue']);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");

  //first we update it in firestore
  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": emptyList}).then((value) {
    //then in local
    sharedPreferences!.setStringList("userCart", emptyList!);
    Provider.of<CartItemCounter>(context, listen: false)
        .displayCartListItemsNumber();
  });
}
