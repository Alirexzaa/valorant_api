import 'package:flutter/material.dart';
import 'package:valorant_api/pages/agentPage/agent_detail_page.dart';
import 'package:valorant_api/pages/bundlesPage/bundles_page.dart';
import 'package:valorant_api/pages/mapPage/map_page.dart';
import 'package:valorant_api/pages/mapPage/maps_detail.dart';
import 'package:valorant_api/pages/home_page.dart';
import 'package:valorant_api/pages/agentPage/agent_page.dart';
import 'package:valorant_api/pages/sprayPage/sprays_page.dart';
import 'package:valorant_api/pages/weaponPage/weapons_detail.dart';
import 'package:valorant_api/pages/weaponPage/weapons_page.dart';

import '../pages/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => const Splash(),
  AgentDetail.routeName: (context) => const AgentDetail(),
  WeaponsPage.routeName: (context) => const WeaponsPage(),
  WeaponsDetail.routeName: (context) => const WeaponsDetail(),
  MapPage.routeName: (context) => const MapPage(),
  MapsDetail.routeName: (context) => const MapsDetail(),
  NewAgentPage.routeName: (context) => const NewAgentPage(),
  NewHomePage.routeName: (context) => const NewHomePage(),
  SpraysPage.routeName: (context) => const SpraysPage(),
  BundlesPage.routeName: (context) => const BundlesPage(),
};
