// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Agents welcomeFromJson(String str) => Agents.fromJson(json.decode(str));

String welcomeToJson(Agents data) => json.encode(data.toJson());

class Agents {
  int status;
  List<AgentsData> data;

  Agents({
    required this.status,
    required this.data,
  });

  factory Agents.fromJson(Map<String, dynamic> json) => Agents(
        status: json["status"],
        data: List<AgentsData>.from(
            json["data"].map((x) => AgentsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AgentsData {
  String uuid;
  String displayName;
  String description;
  String developerName;
  List<String>? characterTags;
  String displayIcon;
  String displayIconSmall;
  String? bustPortrait;
  String? fullPortrait;
  String? fullPortraitV2;
  String killfeedPortrait;
  String? background;
  List<String> backgroundGradientColors;
  String assetPath;
  bool isFullPortraitRightFacing;
  bool isPlayableCharacter;
  bool isAvailableForTest;
  bool isBaseContent;
  Role? role;
  RecruitmentData? recruitmentData;
  List<Ability> abilities;
  dynamic voiceLine;

  AgentsData({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.developerName,
    required this.characterTags,
    required this.displayIcon,
    required this.displayIconSmall,
    required this.bustPortrait,
    required this.fullPortrait,
    required this.fullPortraitV2,
    required this.killfeedPortrait,
    required this.background,
    required this.backgroundGradientColors,
    required this.assetPath,
    required this.isFullPortraitRightFacing,
    required this.isPlayableCharacter,
    required this.isAvailableForTest,
    required this.isBaseContent,
    required this.role,
    required this.recruitmentData,
    required this.abilities,
    required this.voiceLine,
  });

  factory AgentsData.fromJson(Map<String, dynamic> json) => AgentsData(
        uuid: json["uuid"],
        displayName: json["displayName"],
        description: json["description"],
        developerName: json["developerName"],
        characterTags: json["characterTags"] == null
            ? []
            : List<String>.from(json["characterTags"]!.map((x) => x)),
        displayIcon: json["displayIcon"],
        displayIconSmall: json["displayIconSmall"],
        bustPortrait: json["bustPortrait"],
        fullPortrait: json["fullPortrait"],
        fullPortraitV2: json["fullPortraitV2"],
        killfeedPortrait: json["killfeedPortrait"],
        background: json["background"],
        backgroundGradientColors:
            List<String>.from(json["backgroundGradientColors"].map((x) => x)),
        assetPath: json["assetPath"],
        isFullPortraitRightFacing: json["isFullPortraitRightFacing"],
        isPlayableCharacter: json["isPlayableCharacter"],
        isAvailableForTest: json["isAvailableForTest"],
        isBaseContent: json["isBaseContent"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        recruitmentData: json["recruitmentData"] == null
            ? null
            : RecruitmentData.fromJson(json["recruitmentData"]),
        abilities: List<Ability>.from(
            json["abilities"].map((x) => Ability.fromJson(x))),
        voiceLine: json["voiceLine"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayName,
        "description": description,
        "developerName": developerName,
        "characterTags": characterTags == null
            ? []
            : List<dynamic>.from(characterTags!.map((x) => x)),
        "displayIcon": displayIcon,
        "displayIconSmall": displayIconSmall,
        "bustPortrait": bustPortrait,
        "fullPortrait": fullPortrait,
        "fullPortraitV2": fullPortraitV2,
        "killfeedPortrait": killfeedPortrait,
        "background": background,
        "backgroundGradientColors":
            List<dynamic>.from(backgroundGradientColors.map((x) => x)),
        "assetPath": assetPath,
        "isFullPortraitRightFacing": isFullPortraitRightFacing,
        "isPlayableCharacter": isPlayableCharacter,
        "isAvailableForTest": isAvailableForTest,
        "isBaseContent": isBaseContent,
        "role": role?.toJson(),
        "recruitmentData": recruitmentData?.toJson(),
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "voiceLine": voiceLine,
      };

  @override
  String toString() {
    return '$displayName,$description,$background,';
  }
}

class Ability {
  Slot slot;
  String displayName;
  String description;
  String? displayIcon;

  Ability({
    required this.slot,
    required this.displayName,
    required this.description,
    required this.displayIcon,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        slot: slotValues.map[json["slot"]]!,
        displayName: json["displayName"],
        description: json["description"],
        displayIcon: json["displayIcon"],
      );

  Map<String, dynamic> toJson() => {
        "slot": slotValues.reverse[slot],
        "displayName": displayName,
        "description": description,
        "displayIcon": displayIcon,
      };
}

enum Slot { ability1, ability2, grenade, passive, ultimate }

final slotValues = EnumValues({
  "Ability1": Slot.ability1,
  "Ability2": Slot.ability2,
  "Grenade": Slot.grenade,
  "Passive": Slot.passive,
  "Ultimate": Slot.ultimate
});

class RecruitmentData {
  String counterId;
  String milestoneId;
  int milestoneThreshold;
  bool useLevelVpCostOverride;
  int levelVpCostOverride;
  DateTime startDate;
  DateTime endDate;

  RecruitmentData({
    required this.counterId,
    required this.milestoneId,
    required this.milestoneThreshold,
    required this.useLevelVpCostOverride,
    required this.levelVpCostOverride,
    required this.startDate,
    required this.endDate,
  });

  factory RecruitmentData.fromJson(Map<String, dynamic> json) =>
      RecruitmentData(
        counterId: json["counterId"],
        milestoneId: json["milestoneId"],
        milestoneThreshold: json["milestoneThreshold"],
        useLevelVpCostOverride: json["useLevelVpCostOverride"],
        levelVpCostOverride: json["levelVpCostOverride"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "counterId": counterId,
        "milestoneId": milestoneId,
        "milestoneThreshold": milestoneThreshold,
        "useLevelVpCostOverride": useLevelVpCostOverride,
        "levelVpCostOverride": levelVpCostOverride,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
      };
}

class Role {
  String uuid;
  DisplayName displayName;
  String description;
  String displayIcon;
  String assetPath;

  Role({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.displayIcon,
    required this.assetPath,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        uuid: json["uuid"],
        displayName: displayNameValues.map[json["displayName"]]!,
        description: json["description"],
        displayIcon: json["displayIcon"],
        assetPath: json["assetPath"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayNameValues.reverse[displayName],
        "description": description,
        "displayIcon": displayIcon,
        "assetPath": assetPath,
      };
}

enum DisplayName { controller, duelist, initiator, sentinel }

final displayNameValues = EnumValues({
  "Controller": DisplayName.controller,
  "Duelist": DisplayName.duelist,
  "Initiator": DisplayName.initiator,
  "Sentinel": DisplayName.sentinel
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
