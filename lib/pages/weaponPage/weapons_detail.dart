import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:valorant_api/api/dart_api.dart';
import 'package:valorant_api/model/weapons_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WeaponsDetail extends StatefulWidget {
  static String routeName = '/weaponsDetail';

  const WeaponsDetail({super.key});

  @override
  State<WeaponsDetail> createState() => _WeaponsDetailState();
}

class _WeaponsDetailState extends State<WeaponsDetail> {
  int currrentIndex = 0;
  final PageController pageController = PageController(initialPage: 0);

  TextStyle detailStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // Widget _indicator(bool isActive) {
  //   return AnimatedContainer(
  //     duration: const Duration(
  //         milliseconds: 300), // microseconds به milliseconds تغییر داده شد
  //     height: 10.0,
  //     width: isActive ? 20.0 : 8.0,
  //     margin: const EdgeInsets.only(right: 5.0),
  //     decoration: BoxDecoration(
  //       color: Colors.red,
  //       borderRadius: BorderRadius.circular(5.0),
  //     ),
  //   );
  // }

  // List<Widget> _buildIndicator(int len) {
  //   return List.generate(len, (index) => _indicator(index == currrentIndex));
  // }

  @override
  Widget build(BuildContext context) {
    // GET SIZE OF DISPLAY IN USE
    Size size = MediaQuery.of(context).size;
    // GET ARGUMENTS FROM LAST PAGE
    Map pastPage = ModalRoute.of(context)!.settings.arguments as Map;
    List<WeaponsData> weaponData = pastPage['data'];
    int weaponIndex = pastPage['index'];
    // int weaponIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: HexColor('e9404f'),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: FutureBuilder(
          future: fetchWeapons(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // var weaponData = snapshot.data!.data;
              return Stack(
                children: [
// App Bar
                  Positioned(
                    top: 30,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          weaponData[weaponIndex].displayName,
                          style: const TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          weaponData[weaponIndex]
                              .category
                              .split('::')[1]
                              .toString(),
                          style: const TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
// weapon picture
                  Positioned(
                    left: 20,
                    right: 10,
                    top: size.height / 9,
                    child: SizedBox(
                      width: size.width,
                      height: 290,
                      child: Stack(
                        children: [
                          Positioned(
                            child: SvgPicture.asset(
                                height: 220,
                                'assets/images/Weaponspicure_detailpage.svg'),
                          ),
                          Positioned(
                              top:
                                  weaponData[weaponIndex].displayName == 'Melee'
                                      ? 45
                                      : 0,
                              right: 10,
                              left: 10,
                              child: Image.network(
                                  height: weaponData[weaponIndex].displayName ==
                                          'Melee'
                                      ? 110
                                      : 220,
                                  weaponData[weaponIndex].displayIcon)),
                        ],
                      ),
                    ),
                  ),
// Skins
                  Positioned(
                    left: 10,
                    right: 10,
                    top: size.height / 3.3,
                    child: SizedBox(
                      width: size.width,
                      height: 290,
                      child: PageView.builder(
                        controller: pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: weaponData[weaponIndex].skins.length,
                        itemBuilder: (context, index) {
                          return InkResponse(
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 10,
                                  top: 40,
                                  child: SizedBox(
                                    width: size.width - 42,
                                    child: SvgPicture.asset(
                                        height: 250,
                                        width: size.width,
                                        'assets/images/SkinBox.svg'),
                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  left: 30,
                                  child: Text(
                                    weaponData[weaponIndex]
                                        .skins[index]
                                        .displayName,
                                    style: detailStyle,
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 60),
                                    alignment: Alignment.center,
                                    child: Image.network(
                                        height: weaponData[weaponIndex]
                                                    .displayName ==
                                                'Melee'
                                            ? 110
                                            : 110,
                                        weaponData[weaponIndex]
                                                    .skins[index]
                                                    .displayIcon !=
                                                null
                                            ? weaponData[weaponIndex]
                                                .skins[index]
                                                .displayIcon
                                                .toString()
                                            : weaponData[weaponIndex]
                                                .skins[index]
                                                .levels[0]['displayIcon']
                                                .toString()),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: const RoundedRectangleBorder(),
                                    child: SizedBox(
                                      width: 500,
                                      height: 500,
                                      child: ListView.builder(
                                        itemCount: weaponData.length,
                                        itemBuilder: (context, index) {
                                          return weaponData[weaponIndex]
                                                      .skins[index]
                                                      .displayIcon !=
                                                  null
                                              ? InkResponse(
                                                  onTap: () {
                                                    setState(() {
                                                      pageController
                                                          .jumpToPage(index);
                                                    });
                                                  },
                                                  child: Container(
                                                    width: size.width,
                                                    height: 137,
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: [
                                                        Text(weaponData[
                                                                weaponIndex]
                                                            .skins[index]
                                                            .displayName),
                                                        Image.network(
                                                            width: size.width,
                                                            height: 90,
                                                            weaponData[
                                                                    weaponIndex]
                                                                .skins[index]
                                                                .displayIcon
                                                                .toString()),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox();
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  Positioned(
                    top: size.height / 1.79,
                    // bottom: 80.0,
                    // right: 30.0,
                    left: size.width / 4.56,
                    child: SmoothPageIndicator(
                      controller: pageController, // PageController
                      count: weaponData[weaponIndex].skins.length,
                      effect: ScrollingDotsEffect(
                        maxVisibleDots: 11,
                        activeDotColor: HexColor('e9404f'),
                      ), // your preferred effect
                    ),
                  ),
// Information
                  Positioned(
                    left: 10,
                    right: 10,
                    top: size.height / 1.65,
                    child: SvgPicture.asset(
                        width: size.width - 50,
                        'assets/images/detail_weapons.svg'),
                  ),
                  Positioned(
                      left: 40,
                      right: 10,
                      top: size.height / 1.60,
                      child: Text(
                        'Details',
                        style: TextStyle(
                          color: HexColor('e9404f'),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Positioned(
                      left: 40,
                      right: 10,
                      top: size.height / 1.50,
                      child: Text(
                        weaponData[weaponIndex].displayName == 'Melee'
                            ? ''
                            : 'Cost  ${weaponData[weaponIndex].shopData!.cost.toString()}',
                        style: detailStyle,
                      )),
                  Positioned(
                    left: 40,
                    right: 10,
                    top: size.height / 1.40,
                    child: Row(
                      children: [
                        Text(
                          'FireRate',
                          style: detailStyle,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 270,
                          height: 15,
                          child: LinearProgressIndicator(
                              backgroundColor: HexColor('e9404f'),
                              value: (weaponData[weaponIndex]
                                          .weaponStats
                                          ?.fireRate ??
                                      0 * 1.0) /
                                  16),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 40,
                    right: 10,
                    top: size.height / 1.30,
                    child: Column(
                      children: [
                        Text(
                          'runSpeedMultiplier',
                          style: detailStyle,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 300,
                          height: 15,
                          child: LinearProgressIndicator(
                              backgroundColor: HexColor('e9404f'),
                              value: weaponData[weaponIndex]
                                      .weaponStats
                                      ?.runSpeedMultiplier ??
                                  0 * 1.0),
                        ),
                      ],
                    ),
                  ),
                  // Positioned(
                  //   top: 500,
                  //   left: 100,
                  //   right: 100,
                  //   child: SizedBox(
                  //     width: size.width,
                  //     height: 500,
                  //     child: CustomCarousel(
                  //       effectsBuilder: (index, scrollRatio, child) =>
                  //           Transform.translate(
                  //               offset: Offset(0, scrollRatio * 250),
                  //               child: child),
                  //       children: [
                  //         Text('ss'),
                  //         Text('ss'),
                  //         Text('ss'),
                  //         Text('ss'),
                  //         Text('ss'),
                  //         Text('ss'),
                  //         Text('ss'),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
