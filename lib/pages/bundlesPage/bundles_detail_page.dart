import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:valorant_api/api/dart_api.dart';
import 'package:valorant_api/model/weapons_model.dart';

class BundlesDetailPage extends StatefulWidget {
  static String routeName = '/BundlesDetailPage';

  const BundlesDetailPage({super.key});

  @override
  State<BundlesDetailPage> createState() => _BundlesDetailPageState();
}

class _BundlesDetailPageState extends State<BundlesDetailPage> {
  List<WeaponsData> test = [];
  @override
  Widget build(BuildContext context) {
    // Get size of display in use
    Size size = MediaQuery.of(context).size;
    // Get arg from last page
    Map bundlesData = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: HexColor('e9404f'),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Image.network(
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              height: size.height,
              bundlesData['verticalPromoImage'] == null
                  ? bundlesData['displayIcon']
                  : bundlesData['verticalPromoImage'].toString(),
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
              right: 20,
              top: 60,
              child: Text(
                bundlesData['displayName'].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
            Positioned(
              top: 150,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: FutureBuilder(
                  future: fetchWeapons(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var weapons = snapshot.data!.data;
                      return ListView.builder(
                        itemCount: weapons.length,
                        itemBuilder: (context, weaponIndex) {
                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: weapons[weaponIndex].skins.length,
                                itemBuilder: (context, skinIndex) {
                                  final skin =
                                      weapons[weaponIndex].skins[skinIndex];
                                  final displayName =
                                      skin.displayName.split(' ')[0];
                                  final bundleDisplayName =
                                      bundlesData['displayName']
                                          .toString()
                                          .split(' ')[0];

                                  if (displayName.contains(bundleDisplayName)) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkResponse(
                                        onTap: () {
                                          test.add(weapons[weaponIndex]);
                                          print(test);
                                        },
                                        child: SizedBox(
                                          width: size.width,
                                          height: 60,
                                          child: skin.displayIcon == null
                                              ? SizedBox()
                                              : Image.network(
                                                  skin.displayIcon.toString()),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// FutureBuilder(
//               future: fetchWeapons(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   var weapons = snapshot.data!.data;
//                   return ListView.builder(
//                     itemCount: weapons.length,
//                     itemBuilder: (context, index) {
//                       int weaponIndex = index;
//                       return SizedBox(
//                         width: size.width,
//                         height: 90,
//                         child: ListView.builder(
//                           itemCount: weapons[index].skins.length,
//                           itemBuilder: (context, index) {
//                             for (int i = 0; i == index; i++) {
//                               if (weapons[weaponIndex]
//                                   .skins[index]
//                                   .displayName
//                                   .split(' ')[0]
//                                   .contains(bundlesData['displayName']
//                                       .toString()
//                                       .split(' ')[0])) {
//                                 test.add(weapons[weaponIndex]);
//                                 print(test);
//                               }
//                             }
//                             return weapons[weaponIndex]
//                                     .skins[index]
//                                     .displayName
//                                     .split(' ')[0]
//                                     .contains(bundlesData['displayName']
//                                         .toString()
//                                         .split(' ')[0])
//                                 ? InkResponse(
//                                     onTap: () {
//                                       test.add(weapons[weaponIndex]);
//                                       print(test);
//                                     },
//                                     child: SizedBox(
//                                       width: size.width,
//                                       height: 40,
//                                       child: weapons[weaponIndex]
//                                                   .skins[index]
//                                                   .displayIcon ==
//                                               null
//                                           ? SizedBox()
//                                           : Image.network(weapons[weaponIndex]
//                                               .skins[index]
//                                               .displayIcon
//                                               .toString()),
//                                     ),
//                                   )
//                                 // Text(
//                                 //     weapons[weaponIndex]
//                                 //         .skins[index]
//                                 //         .displayName,
//                                 //     style: const TextStyle(
//                                 //       color: Colors.white,
//                                 //       fontSize: 32,
//                                 //     ),
//                                 //   )

//                                 : SizedBox();
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               },
//             ),