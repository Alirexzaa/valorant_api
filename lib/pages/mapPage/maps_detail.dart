import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';

import 'package:valorant_api/api/dart_api.dart';

class MapsDetail extends StatefulWidget {
  static String routeName = '/MapsDetailPage';

  const MapsDetail({super.key});

  @override
  State<MapsDetail> createState() => _MapsDetailState();
}

class _MapsDetailState extends State<MapsDetail> {
  @override
  Widget build(BuildContext context) {
    // GET SIZE OF DISPLAY IN USE
    Size size = MediaQuery.of(context).size;
    // GET ARGUMENTS FROM LAST PAGE
    final int mapIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: HexColor('0f1923'),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: FutureBuilder(
          future: fetchMaps(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var mapData = snapshot.data!.data;
              return Stack(
                children: [
                  Image.network(
                    height: size.height,
                    fit: BoxFit.cover,
                    mapData[mapIndex].splash,
                  ),
                  SizedBox(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 20,
                    child: Text(
                      mapData[mapIndex].displayName,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    right: 10,
                    child: Text(
                      mapData[mapIndex].coordinates.toString(),
                      style: TextStyle(
                          color: HexColor('e9404f'),
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: size.width,
                      height: size.height / 2,
                      child: Stack(
                        children: [
                          Image.network(
                            height: size.height,
                            fit: BoxFit.cover,
                            mapData[mapIndex].displayIcon.toString(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            return const Center(
              child: RiveAnimation.asset('assets/animation/wait.riv'),
            );
          },
        ),
      ),
    );
  }
}
