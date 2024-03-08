import 'package:cloud_firestore/cloud_firestore.dart';

import '../global/global.dart';

List<String> separateOrderItemIDs(List<String> orderIDs) {
  List<String> separateItemIDsList = [];

  for (String orderID in orderIDs) {
    int pos = orderID.lastIndexOf(":");
    String getItemId = (pos != -1) ? orderID.substring(0, pos) : orderID;
    separateItemIDsList.add(getItemId);
  }

  return separateItemIDsList;
}

List<String> separateItemIDs() {
  List<String> separateItemIDsList = [];
  List<String>? defaultItemList = sharedPreferences!.getStringList("userCart");

  if (defaultItemList != null) {
    for (String item in defaultItemList) {
      int pos = item.lastIndexOf(":");
      String getItemId = (pos != -1) ? item.substring(0, pos) : item;
      separateItemIDsList.add(getItemId);
    }
  }

  return separateItemIDsList;
}

List<String> separateOrderItemQuantities(List<String> orderIDs) {
  List<String> separateItemQuantityList = [];

  for (int i = 1; i < orderIDs.length; i++) {
    String item = orderIDs[i];
    List<String> listItemCharacters = item.split(":");
    int quanNumber = int.tryParse(listItemCharacters[1]) ?? 0;
    separateItemQuantityList.add(quanNumber.toString());
  }

  return separateItemQuantityList;
}

List<int> separateItemQuantities() {
  List<int> separateItemQuantityList = [];
  List<String>? defaultItemList = sharedPreferences!.getStringList("userCart");

  if (defaultItemList != null) {
    for (int i = 1; i < defaultItemList.length; i++) {
      String item = defaultItemList[i];
      List<String> listItemCharacters = item.split(":");
      int quanNumber = int.tryParse(listItemCharacters[1]) ?? 0;
      separateItemQuantityList.add(quanNumber);
    }
  }

  return separateItemQuantityList;
}

void clearCartNow(context) {
  sharedPreferences!.setStringList("userCart", ['garbageValue']);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");

  if (emptyList != null) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .update({"userCart": emptyList}).then((value) {
      sharedPreferences!.setStringList("userCart", emptyList);
    }).catchError((error) {
      // Handle error
    });
  }
}
