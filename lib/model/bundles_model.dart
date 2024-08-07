// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Bundles welcomeFromJson(String str) => Bundles.fromJson(json.decode(str));

String welcomeToJson(Bundles data) => json.encode(data.toJson());

class Bundles {
  int status;
  List<BundlesData> data;

  Bundles({
    required this.status,
    required this.data,
  });

  factory Bundles.fromJson(Map<String, dynamic> json) => Bundles(
        status: json["status"],
        data: List<BundlesData>.from(
            json["data"].map((x) => BundlesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BundlesData {
  String uuid;
  String displayName;
  String description;
  String displayIcon;
  String displayIcon2;
  String? verticalPromoImage;

  BundlesData({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.displayIcon,
    required this.displayIcon2,
    required this.verticalPromoImage,
  });

  factory BundlesData.fromJson(Map<String, dynamic> json) => BundlesData(
        uuid: json["uuid"],
        displayName: json["displayName"],
        description: json["description"],
        displayIcon: json["displayIcon"],
        displayIcon2: json["displayIcon2"],
        verticalPromoImage: json["verticalPromoImage"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayName,
        "description": description,
        "displayIcon": displayIcon,
        "displayIcon2": displayIcon2,
        "verticalPromoImage": verticalPromoImage,
      };
  @override
  String toString() {
    return '$displayName,$description,$displayIcon,';
  }
}
