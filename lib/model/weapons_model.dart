// // To parse this JSON data, do
// //
// //     final weapons = weaponsFromJson(jsonString);

import 'dart:convert';

Weapons weaponsFromJson(String str) => Weapons.fromJson(json.decode(str));

String weaponsToJson(Weapons data) => json.encode(data.toJson());

class Weapons {
  int status;
  // List data;
  List<WeaponsData> data;

  Weapons({
    required this.status,
    required this.data,
  });

  factory Weapons.fromJson(Map<String, dynamic> json) => Weapons(
        status: json["status"],
        // data: json["data"],
        data: List<WeaponsData>.from(
            json["data"].map((x) => WeaponsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        // "data": data,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WeaponsData {
  String uuid;
  String displayName;
  String category;
  String defaultSkinUuid;
  String displayIcon;
  String killStreamIcon;
  String assetPath;
  WeaponStats? weaponStats;
  ShopData? shopData;
  List<Skin> skins;

  WeaponsData({
    required this.uuid,
    required this.displayName,
    required this.category,
    required this.defaultSkinUuid,
    required this.displayIcon,
    required this.killStreamIcon,
    required this.assetPath,
    required this.weaponStats,
    required this.shopData,
    required this.skins,
  });

  factory WeaponsData.fromJson(Map<String, dynamic> json) => WeaponsData(
        uuid: json["uuid"],
        displayName: json["displayName"],
        category: json["category"],
        defaultSkinUuid: json["defaultSkinUuid"],
        displayIcon: json["displayIcon"],
        killStreamIcon: json["killStreamIcon"],
        assetPath: json["assetPath"],
        weaponStats: json["weaponStats"] == null
            ? null
            : WeaponStats.fromJson(json["weaponStats"]),
        shopData: json["shopData"] == null
            ? null
            : ShopData.fromJson(json["shopData"]),
        skins: List<Skin>.from(json["skins"].map((x) => Skin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayName,
        "category": category,
        "defaultSkinUuid": defaultSkinUuid,
        "displayIcon": displayIcon,
        "killStreamIcon": killStreamIcon,
        "assetPath": assetPath,
        "weaponStats": weaponStats?.toJson(),
        "shopData": shopData?.toJson(),
        "skins": List<dynamic>.from(skins.map((x) => x.toJson())),
      };
}

class ShopData {
  int cost;
  String category;
  int shopOrderPriority;
  String categoryText;
  GridPosition? gridPosition;
  bool canBeTrashed;
  dynamic image;
  String newImage;
  dynamic newImage2;
  String assetPath;

  ShopData({
    required this.cost,
    required this.category,
    required this.shopOrderPriority,
    required this.categoryText,
    required this.gridPosition,
    required this.canBeTrashed,
    required this.image,
    required this.newImage,
    required this.newImage2,
    required this.assetPath,
  });

  factory ShopData.fromJson(Map<String, dynamic> json) => ShopData(
        cost: json["cost"],
        category: json["category"],
        shopOrderPriority: json["shopOrderPriority"],
        categoryText: json["categoryText"],
        gridPosition: json["gridPosition"] == null
            ? null
            : GridPosition.fromJson(json["gridPosition"]),
        canBeTrashed: json["canBeTrashed"],
        image: json["image"],
        newImage: json["newImage"],
        newImage2: json["newImage2"],
        assetPath: json["assetPath"],
      );

  Map<String, dynamic> toJson() => {
        "cost": cost,
        "category": category,
        "shopOrderPriority": shopOrderPriority,
        "categoryText": categoryText,
        "gridPosition": gridPosition?.toJson(),
        "canBeTrashed": canBeTrashed,
        "image": image,
        "newImage": newImage,
        "newImage2": newImage2,
        "assetPath": assetPath,
      };
}

class GridPosition {
  int row;
  int column;

  GridPosition({
    required this.row,
    required this.column,
  });

  factory GridPosition.fromJson(Map<String, dynamic> json) => GridPosition(
        row: json["row"],
        column: json["column"],
      );

  Map<String, dynamic> toJson() => {
        "row": row,
        "column": column,
      };
}

class Skin {
  String uuid;
  String displayName;
  String themeUuid;
  String? contentTierUuid;
  String? displayIcon;
  String? wallpaper;
  String assetPath;
  List levels;

  Skin({
    required this.uuid,
    required this.displayName,
    required this.themeUuid,
    required this.contentTierUuid,
    required this.displayIcon,
    required this.wallpaper,
    required this.assetPath,
    required this.levels,
  });

  factory Skin.fromJson(Map<String, dynamic> json) => Skin(
        uuid: json["uuid"],
        displayName: json["displayName"],
        themeUuid: json["themeUuid"],
        contentTierUuid: json["contentTierUuid"],
        displayIcon: json["displayIcon"],
        wallpaper: json["wallpaper"],
        assetPath: json["assetPath"],
        levels: json["levels"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayName,
        "themeUuid": themeUuid,
        "contentTierUuid": contentTierUuid,
        "displayIcon": displayIcon,
        "wallpaper": wallpaper,
        "assetPath": assetPath,
        "levels": List<dynamic>.from(levels.map((x) => x.toJson())),
      };
}

class WeaponStats {
  double fireRate;
  int magazineSize;
  double runSpeedMultiplier;
  double equipTimeSeconds;
  double reloadTimeSeconds;
  double firstBulletAccuracy;
  int shotgunPelletCount;
  String? feature;
  String? fireMode;
  List<DamageRange> damageRanges;

  WeaponStats({
    required this.fireRate,
    required this.magazineSize,
    required this.runSpeedMultiplier,
    required this.equipTimeSeconds,
    required this.reloadTimeSeconds,
    required this.firstBulletAccuracy,
    required this.shotgunPelletCount,
    required this.feature,
    required this.fireMode,
    required this.damageRanges,
  });

  factory WeaponStats.fromJson(Map<String, dynamic> json) => WeaponStats(
        fireRate: json["fireRate"]?.toDouble(),
        magazineSize: json["magazineSize"],
        runSpeedMultiplier: json["runSpeedMultiplier"]?.toDouble(),
        equipTimeSeconds: json["equipTimeSeconds"]?.toDouble(),
        reloadTimeSeconds: json["reloadTimeSeconds"]?.toDouble(),
        firstBulletAccuracy: json["firstBulletAccuracy"]?.toDouble(),
        shotgunPelletCount: json["shotgunPelletCount"],
        feature: json["feature"],
        fireMode: json["fireMode"],
        damageRanges: List<DamageRange>.from(
            json["damageRanges"].map((x) => DamageRange.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fireRate": fireRate,
        "magazineSize": magazineSize,
        "runSpeedMultiplier": runSpeedMultiplier,
        "equipTimeSeconds": equipTimeSeconds,
        "reloadTimeSeconds": reloadTimeSeconds,
        "firstBulletAccuracy": firstBulletAccuracy,
        "shotgunPelletCount": shotgunPelletCount,
        "feature": feature,
        "fireMode": fireMode,
        "damageRanges": List<dynamic>.from(damageRanges.map((x) => x.toJson())),
      };
}

class DamageRange {
  int rangeStartMeters;
  int rangeEndMeters;
  double headDamage;
  int bodyDamage;
  double legDamage;

  DamageRange({
    required this.rangeStartMeters,
    required this.rangeEndMeters,
    required this.headDamage,
    required this.bodyDamage,
    required this.legDamage,
  });

  factory DamageRange.fromJson(Map<String, dynamic> json) => DamageRange(
        rangeStartMeters: json["rangeStartMeters"],
        rangeEndMeters: json["rangeEndMeters"],
        headDamage: json["headDamage"]?.toDouble(),
        bodyDamage: json["bodyDamage"],
        legDamage: json["legDamage"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "rangeStartMeters": rangeStartMeters,
        "rangeEndMeters": rangeEndMeters,
        "headDamage": headDamage,
        "bodyDamage": bodyDamage,
        "legDamage": legDamage,
      };
}
