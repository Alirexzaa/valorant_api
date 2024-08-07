import 'package:flutter/material.dart';

import 'package:valorant_api/routes/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/NewHomePage',
      routes: routes,
    );
  }
}
