// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Maps welcomeFromJson(String str) => Maps.fromJson(json.decode(str));

String welcomeToJson(Maps data) => json.encode(data.toJson());

class Maps {
  int status;
  List<MapsData> data;

  Maps({
    required this.status,
    required this.data,
  });

  factory Maps.fromJson(Map<String, dynamic> json) => Maps(
        status: json["status"],
        data:
            List<MapsData>.from(json["data"].map((x) => MapsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MapsData {
  String uuid;
  String displayName;
  dynamic narrativeDescription;
  TacticalDescription? tacticalDescription;
  String? coordinates;
  String? displayIcon;
  String listViewIcon;
  String listViewIconTall;
  String splash;
  String? stylizedBackgroundImage;
  String? premierBackgroundImage;
  String assetPath;
  String mapUrl;
  double xMultiplier;
  double yMultiplier;
  double xScalarToAdd;
  double yScalarToAdd;
  List<Callout>? callouts;

  MapsData({
    required this.uuid,
    required this.displayName,
    required this.narrativeDescription,
    required this.tacticalDescription,
    required this.coordinates,
    required this.displayIcon,
    required this.listViewIcon,
    required this.listViewIconTall,
    required this.splash,
    required this.stylizedBackgroundImage,
    required this.premierBackgroundImage,
    required this.assetPath,
    required this.mapUrl,
    required this.xMultiplier,
    required this.yMultiplier,
    required this.xScalarToAdd,
    required this.yScalarToAdd,
    required this.callouts,
  });

  factory MapsData.fromJson(Map<String, dynamic> json) => MapsData(
        uuid: json["uuid"],
        displayName: json["displayName"],
        narrativeDescription: json["narrativeDescription"],
        tacticalDescription:
            tacticalDescriptionValues.map[json["tacticalDescription"]],
        coordinates: json["coordinates"],
        displayIcon: json["displayIcon"],
        listViewIcon: json["listViewIcon"],
        listViewIconTall: json["listViewIconTall"],
        splash: json["splash"],
        stylizedBackgroundImage: json["stylizedBackgroundImage"],
        premierBackgroundImage: json["premierBackgroundImage"],
        assetPath: json["assetPath"],
        mapUrl: json["mapUrl"],
        xMultiplier: json["xMultiplier"]?.toDouble(),
        yMultiplier: json["yMultiplier"]?.toDouble(),
        xScalarToAdd: json["xScalarToAdd"]?.toDouble(),
        yScalarToAdd: json["yScalarToAdd"]?.toDouble(),
        callouts: json["callouts"] == null
            ? []
            : List<Callout>.from(
                json["callouts"]!.map((x) => Callout.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayName,
        "narrativeDescription": narrativeDescription,
        "tacticalDescription":
            tacticalDescriptionValues.reverse[tacticalDescription],
        "coordinates": coordinates,
        "displayIcon": displayIcon,
        "listViewIcon": listViewIcon,
        "listViewIconTall": listViewIconTall,
        "splash": splash,
        "stylizedBackgroundImage": stylizedBackgroundImage,
        "premierBackgroundImage": premierBackgroundImage,
        "assetPath": assetPath,
        "mapUrl": mapUrl,
        "xMultiplier": xMultiplier,
        "yMultiplier": yMultiplier,
        "xScalarToAdd": xScalarToAdd,
        "yScalarToAdd": yScalarToAdd,
        "callouts": callouts == null
            ? []
            : List<dynamic>.from(callouts!.map((x) => x.toJson())),
      };
  @override
  String toString() {
    return '$displayName,$mapUrl,$premierBackgroundImage,';
  }
}

class Callout {
  String regionName;
  SuperRegionName superRegionName;
  Location location;

  Callout({
    required this.regionName,
    required this.superRegionName,
    required this.location,
  });

  factory Callout.fromJson(Map<String, dynamic> json) => Callout(
        regionName: json["regionName"],
        superRegionName: superRegionNameValues.map[json["superRegionName"]]!,
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "regionName": regionName,
        "superRegionName": superRegionNameValues.reverse[superRegionName],
        "location": location.toJson(),
      };
}

class Location {
  double x;
  double y;

  Location({
    required this.x,
    required this.y,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}

enum SuperRegionName { A, attackeSide, B, C, defenderSide, mid }

final superRegionNameValues = EnumValues({
  "A": SuperRegionName.A,
  "Attacker Side": SuperRegionName.attackeSide,
  "B": SuperRegionName.B,
  "C": SuperRegionName.C,
  "Defender Side": SuperRegionName.defenderSide,
  "Mid": SuperRegionName.mid
});

enum TacticalDescription { abcSites, absites }

final tacticalDescriptionValues = EnumValues({
  "A/B/C Sites": TacticalDescription.abcSites,
  "A/B Sites": TacticalDescription.absites
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
