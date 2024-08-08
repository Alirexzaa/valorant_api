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
  int skinIndex = 0;
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor('e9404f'),
        title: Text(
          weaponData[weaponIndex].displayName,
          style: const TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              weaponData[weaponIndex].category.split('::')[1].toString(),
              style: const TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: HexColor('e9404f'),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: FutureBuilder(
          future: fetchWeapons(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // var weaponData = snapshot.data!.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // weapon picture
                    SizedBox(
                      width: 500,
                      height: 220,
                      child: Stack(
                        children: [
                          Center(
                            child: SvgPicture.asset(
                                height: 220,
                                'assets/images/Weaponspicure_detailpage.svg'),
                          ),
                          Positioned(
                            top: 30,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Image.network(
                                  height: weaponData[weaponIndex].displayName ==
                                          'Melee'
                                      ? 110
                                      : 220,
                                  weaponData[weaponIndex].displayIcon),
                            ),
                          ),
                          Positioned(
                              top: 10,
                              left: 30,
                              child: Text(
                                "Defult Skin",
                                style: TextStyle(
                                  color: HexColor('e9404f'),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                    ),
                    // Skins
                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      width: 500,
                      height: 260,
                      child: Stack(
                        children: [
                          PageView.builder(
                            onPageChanged: (value) {
                              setState(() {
                                skinIndex = value;
                              });
                            },
                            controller: pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: weaponData[weaponIndex].skins.length,
                            itemBuilder: (context, index) {
                              return InkResponse(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 10,
                                      child: SizedBox(
                                        width: size.width - 42,
                                        child: SvgPicture.asset(
                                            width: size.width,
                                            'assets/images/SkinBox.svg'),
                                      ),
                                    ),
                                    Positioned(
                                      top: 30,
                                      right: 30,
                                      child: Text(
                                        weaponData[weaponIndex]
                                            .skins[index]
                                            .displayName,
                                        style: detailStyle,
                                      ),
                                    ),
                                    Positioned(
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 30),
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
                                                              .jumpToPage(
                                                                  index);
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                                seconds: 1),
                                                        color:
                                                            skinIndex == index
                                                                ? Colors.grey
                                                                : Colors.white,
                                                        width: size.width,
                                                        height: 137,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Column(
                                                          children: [
                                                            Text(weaponData[
                                                                    weaponIndex]
                                                                .skins[index]
                                                                .displayName),
                                                            Image.network(
                                                                width:
                                                                    size.width,
                                                                height: 90,
                                                                weaponData[
                                                                        weaponIndex]
                                                                    .skins[
                                                                        index]
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
                          Positioned(
                            bottom: 30,
                            left: 80,
                            right: 10,
                            child: SmoothPageIndicator(
                              controller: pageController, // PageController
                              count: weaponData[weaponIndex].skins.length,
                              effect: ScrollingDotsEffect(
                                maxVisibleDots: 11,
                                activeDotColor: HexColor('e9404f'),
                              ), // your preferred effect
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Information
                    SizedBox(
                      width: size.width,
                      height: 323,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 10,
                            right: 10,
                            child: SvgPicture.asset(
                                width: size.width - 40,
                                'assets/images/detail_weapons.svg'),
                          ),
                          Positioned(
                            top: 10,
                            left: 40,
                            right: 10,
                            child: Text(
                              'Details',
                              style: TextStyle(
                                color: HexColor('e9404f'),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                              top: 50,
                              left: 40,
                              right: 10,
                              child: Text(
                                weaponData[weaponIndex].displayName == 'Melee'
                                    ? ''
                                    : 'Cost  ${weaponData[weaponIndex].shopData!.cost.toString()}',
                                style: detailStyle,
                              )),
                          Positioned(
                            top: 90,
                            left: 40,
                            right: 10,
                            child: Text(
                              'Fire Rate : ${weaponData[weaponIndex].displayName == 'Melee' ? '' : weaponData[weaponIndex].weaponStats!.fireRate}',
                              style: detailStyle,
                            ),
                          ),
                          Positioned(
                            top: 120,
                            left: 40,
                            right: 110,
                            child: SizedBox(
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
                          ),
                          Positioned(
                            top: 150,
                            left: 40,
                            right: 10,
                            child: Text(
                              'Run Speed Multiplier : ${weaponData[weaponIndex].displayName == 'Melee' ? '' : weaponData[weaponIndex].weaponStats!.runSpeedMultiplier}',
                              style: detailStyle,
                            ),
                          ),
                          Positioned(
                            top: 180,
                            left: 40,
                            right: 110,
                            child: SizedBox(
                              width: 270,
                              height: 15,
                              child: LinearProgressIndicator(
                                  backgroundColor: HexColor('e9404f'),
                                  value: (weaponData[weaponIndex]
                                              .weaponStats
                                              ?.runSpeedMultiplier ??
                                          0 * 1.0) /
                                      16),
                            ),
                          ),
                          Positioned(
                            top: 210,
                            left: 40,
                            right: 10,
                            child: Text(
                              'reloadTimeSeconds : ${weaponData[weaponIndex].displayName == 'Melee' ? '' : weaponData[weaponIndex].weaponStats!.reloadTimeSeconds}',
                              style: detailStyle,
                            ),
                          ),
                          Positioned(
                            top: 240,
                            left: 40,
                            right: 110,
                            child: SizedBox(
                              width: 270,
                              height: 15,
                              child: LinearProgressIndicator(
                                  backgroundColor: HexColor('e9404f'),
                                  value: (weaponData[weaponIndex]
                                              .weaponStats
                                              ?.reloadTimeSeconds ??
                                          0 * 1.0) /
                                      16),
                            ),
                          )
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
                ),
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
