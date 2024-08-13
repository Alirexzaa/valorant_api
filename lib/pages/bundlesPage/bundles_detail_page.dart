import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';
import 'package:valorant_api/api/dart_api.dart';
import 'package:valorant_api/model/weapons_model.dart';
import 'package:valorant_api/pages/skin_video_play.dart';

class BundlesDetailPage extends StatefulWidget {
  static String routeName = '/BundlesDetailPage';

  const BundlesDetailPage({super.key});

  @override
  State<BundlesDetailPage> createState() => _BundlesDetailPageState();
}

class _BundlesDetailPageState extends State<BundlesDetailPage> {
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
            // background Image
            Image.network(
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              height: size.height,
              bundlesData['verticalPromoImage'] == null
                  ? bundlesData['displayIcon']
                  : bundlesData['verticalPromoImage'].toString(),
            ),
            // blure Filter
            SizedBox(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
            // AppBar
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
              top: 60,
              left: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: HexColor('e9404f'),
                ),
              ),
            ),
            // Body
            Positioned(
              top: 120,
              child: SizedBox(
                width: size.width,
                height: size.height - 120,
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
                                    return customWeapons(skin, size, weapons,
                                        weaponIndex, context);
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return const Center(
                      child: RiveAnimation.asset('assets/animation/wait.riv'),
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

  Padding customWeapons(Skin skin, Size size, List<WeaponsData> weapons,
      int weaponIndex, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 230,
        decoration: BoxDecoration(
          color: HexColor('0f1923'),
          border: Border.all(
            color: HexColor('ff4655'),
          ),
        ),
        child: skin.displayIcon == null
            ? const SizedBox()
            : Stack(
                children: [
                  skin.wallpaper == null
                      ? const SizedBox()
                      : Image.network(
                          filterQuality: FilterQuality.high,
                          width: size.width,
                          skin.wallpaper.toString(),
                        ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.network(
                      filterQuality: FilterQuality.high,
                      height: 120,
                      skin.displayIcon.toString(),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Text(
                      weapons[weaponIndex]
                          .category
                          .split('::')[1]
                          .toUpperCase(),
                      style: TextStyle(
                        color: HexColor('ff4655'),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  skin.levels[0]['streamedVideo'] == null
                      ? const SizedBox()
                      : Positioned(
                          left: 20,
                          bottom: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SkinVideoPage(
                                    videoUrl: skin.levels[0]['streamedVideo'],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              size: 50,
                              color: HexColor('ff4655'),
                              Icons.play_circle_filled_sharp,
                            ),
                          ),
                        ),
                  Positioned(
                    right: 20,
                    left: 150,
                    top: 20,
                    child: Text(
                      skin.displayName,
                      style: TextStyle(
                        color: HexColor('ff4655'),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
