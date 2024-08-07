import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:valorant_api/model/maps_model.dart';
import 'package:valorant_api/model/sprays_model.dart';
import 'package:valorant_api/model/weapons_model.dart';
import 'package:valorant_api/model/agents_model.dart';

Future<Agents> fetchAgents() async {
  final response =
      await http.get(Uri.https('www.valorant-api.com', '/v1/agents'));

  if (response.statusCode == 200) {
    return Agents.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('FAILD TO LOAD AGENST');
  }
}

Future<Maps> fetchMaps() async {
  final response =
      await http.get(Uri.https('www.valorant-api.com', '/v1/maps'));

  if (response.statusCode == 200) {
    return Maps.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('FAILD TO LOAD Maps');
  }
}

Future<Weapons> fetchWeapons() async {
  final response =
      await http.get(Uri.https('www.valorant-api.com', '/v1/weapons'));

  if (response.statusCode == 200) {
    return Weapons.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('FAILD TO LOAD Weapons');
  }
}

Future<Sprays> fetchSprays() async {
  final response =
      await http.get(Uri.https('www.valorant-api.com', '/v1/sprays'));

  if (response.statusCode == 200) {
    return Sprays.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('FAILD TO LOAD Sprays');
  }
}
