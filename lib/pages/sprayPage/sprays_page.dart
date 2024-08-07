import 'package:flutter/material.dart';
import 'package:valorant_api/api/dart_api.dart';

class SpraysPage extends StatefulWidget {
  static String routeName = '/SpraysPag';

  const SpraysPage({super.key});

  @override
  State<SpraysPage> createState() => _SpraysPageState();
}

class _SpraysPageState extends State<SpraysPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SizedBox(
      width: size.width,
      height: size.height,
      child: FutureBuilder(
        future: fetchSprays(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data!.status.toString()),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}
