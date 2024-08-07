import 'package:flutter/material.dart';

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
                          Positioned(
                            // x	4489.032
                            // y	-3014.0515
                            top: 44 + 80,
                            left: 301,
                            child: Container(
                              width: 40,
                              height: 20,
                              color: Colors.red,
                              child: Text(
                                  mapData[mapIndex].callouts![1].regionName),
                            ),
                          ),
                          Positioned(
                            top: 61 + 100,
                            left: 66,
                            child: Container(
                              // x	6153.585
                              // y	-6626.2114
                              width: 40,
                              height: 20,
                              color: Colors.blue,
                              child: Text(
                                  mapData[mapIndex].callouts![4].regionName),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
