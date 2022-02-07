import 'package:cloud_firestore/cloud_firestore.dart';

class Menus {
  String? menuID;
  String? sellerUID;
  String? menuTitle;
  String? menuInfo;
  Timestamp? publishDate;
  String? thumbnailUrl;
  String? status;

  Menus({
    this.menuID,
    this.menuInfo,
    this.menuTitle,
    this.publishDate,
    this.sellerUID,
    this.status,
    this.thumbnailUrl,
  });

  Menus.fromJson(Map<String, dynamic> json) {
    menuID = json["menuID"];
    menuInfo = json["menuInfo"];
    menuTitle = json["menuTitle"];
    publishDate = json["publishDate"];
    sellerUID = json["sellerUID"];
    status = json["status"];
    thumbnailUrl = json["thumbnailUrl"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["menuID"] = menuID;
    data["menuInfo"] = menuInfo;
    data["menuTitle"] = menuTitle;
    data["publishDate"] = publishDate;
    data["sellerUID"] = sellerUID;
    data["status"] = status;
    data["thumbnailUrl"] = thumbnailUrl;
    return data;
  }
}
