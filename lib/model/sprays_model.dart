class Sprays {
  int status;
  List<Datas> data;

  Sprays({
    required this.status,
    required this.data,
  });

  factory Sprays.fromJson(Map<String, dynamic> json) => Sprays(
        status: json["status"],
        data: List<Datas>.from(json["data"].map((x) => Datas.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datas {
  String displayName;
  String? themeUuid;
  bool isNullSpray;
  bool hideIfNotOwned;
  String displayIcon;
  String? fullIcon;
  String? fullTransparentIcon;
  String? animationPng;
  String? animationGif;
  List<Level> levels;

  Datas({
    required this.displayName,
    required this.themeUuid,
    required this.isNullSpray,
    required this.hideIfNotOwned,
    required this.displayIcon,
    required this.fullIcon,
    required this.fullTransparentIcon,
    required this.animationPng,
    required this.animationGif,
    required this.levels,
  });

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        displayName: json["displayName"],
        themeUuid: json["themeUuid"],
        isNullSpray: json["isNullSpray"],
        hideIfNotOwned: json["hideIfNotOwned"],
        displayIcon: json["displayIcon"],
        fullIcon: json["fullIcon"],
        fullTransparentIcon: json["fullTransparentIcon"],
        animationPng: json["animationPng"],
        animationGif: json["animationGif"],
        levels: List<Level>.from(json["levels"].map((x) => Level.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "themeUuid": themeUuid,
        "isNullSpray": isNullSpray,
        "hideIfNotOwned": hideIfNotOwned,
        "displayIcon": displayIcon,
        "fullIcon": fullIcon,
        "fullTransparentIcon": fullTransparentIcon,
        "animationPng": animationPng,
        "animationGif": animationGif,
        "levels": List<dynamic>.from(levels.map((x) => x.toJson())),
      };
}

class Level {
  int sprayLevel;
  String displayName;
  String? displayIcon;

  Level({
    required this.sprayLevel,
    required this.displayName,
    required this.displayIcon,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        sprayLevel: json["sprayLevel"],
        displayName: json["displayName"],
        displayIcon: json["displayIcon"],
      );

  Map<String, dynamic> toJson() => {
        "sprayLevel": sprayLevel,
        "displayName": displayName,
        "displayIcon": displayIcon,
      };
}
