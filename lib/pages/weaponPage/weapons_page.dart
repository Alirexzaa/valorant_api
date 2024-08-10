import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';
import 'package:valorant_api/api/dart_api.dart';
import 'package:valorant_api/model/weapons_model.dart';

class WeaponsPage extends StatefulWidget {
  static String routeName = '/WeaponsPage';

  const WeaponsPage({super.key});

  @override
  State<WeaponsPage> createState() => _WeaponsState();
}

class _WeaponsState extends State<WeaponsPage> {
  String currentItemSelected = 'All';
  bool selectedFilter = false;
  int selectedWeaponIndex = 0;
  int selectedFilterIndex = 0;

  TextEditingController searchController = TextEditingController();

  Map<String, dynamic> nextpage = {};

  List<WeaponsData> fillterWeapons = [];

  List<String> filterName = [
    'all',
    'heavy',
    'rifle',
    'shotgun',
    'sidearm',
    'sniper',
    'smg',
    'melee',
  ];
  int filterSelectedInedx = 0;

  TextStyle detailStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('0f1923'),
        title: const Text(
          'Weapons',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            color: HexColor('ff4655'),
            Icons.arrow_back_ios_outlined,
          ),
        ),
      ),
      backgroundColor: HexColor('0f1923'),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              // Filters
              SizedBox(
                width: size.width,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: FutureBuilder(
                    future: fetchWeapons(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var weapons = snapshot.data!.data;
                        return GridView.builder(
                          itemCount: filterName.length,
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 100,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return InkResponse(
                              onTap: () {
                                setState(() {
                                  filterSelectedInedx = index;
                                  fillterWeapons = weapons
                                      .where(
                                        (element) =>
                                            element.category
                                                .split('::')[1]
                                                .toLowerCase() ==
                                            filterName[index],
                                      )
                                      .toList();
                                  print(fillterWeapons.length);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: filterSelectedInedx == index
                                        ? HexColor('ff4655')
                                        : HexColor('0f1923'),
                                    border: Border.all(
                                      color: HexColor('ff4655'),
                                    ),
                                  ),
                                  child: Text(
                                    filterName[index],
                                    style: TextStyle(
                                      color: filterSelectedInedx == index
                                          ? HexColor('0f1923')
                                          : HexColor('ff4655'),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
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
              ),
              const SizedBox(height: 20),
              // Weapons Image
              SizedBox(
                height: size.height - 200,
                width: size.width - 30,
                child: FutureBuilder(
                  future: fetchWeapons(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var weapons = snapshot.data!.data;
                      return ListView.builder(
                        itemCount: fillterWeapons.isEmpty
                            ? weapons.length
                            : fillterWeapons.length,
                        itemBuilder: (context, index) {
                          return InkResponse(
                            onTap: () {
                              setState(() {
                                selectedFilterIndex = index;
                                nextpage['data'] = fillterWeapons.isEmpty
                                    ? weapons
                                    : fillterWeapons;
                                nextpage['index'] = selectedFilterIndex;
                                Navigator.pushNamed(context, '/weaponsDetail',
                                    arguments: nextpage);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 220,
                                height: 220,
                                decoration: BoxDecoration(
                                  border: Border.all(color: HexColor('ff4655')),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(),
                                    Image.network(
                                        height: 100,
                                        fillterWeapons.isEmpty
                                            ? weapons[index]
                                                .displayIcon
                                                .toString()
                                            : fillterWeapons[index]
                                                .displayIcon),
                                    Container(
                                      width: size.width,
                                      height: 60,
                                      color: HexColor('ff4655'),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              fillterWeapons.isEmpty
                                                  ? weapons[index].displayName
                                                  : fillterWeapons[index]
                                                      .displayName,
                                              style: TextStyle(
                                                color: HexColor('0f1923'),
                                                fontSize: 28,
                                              ),
                                            ),
                                            Text(
                                              fillterWeapons.isEmpty
                                                  ? weapons[index]
                                                      .category
                                                      .split('::')[1]
                                                      .toUpperCase()
                                                  : fillterWeapons[index]
                                                      .category
                                                      .split('::')[1]
                                                      .toUpperCase(),
                                              style: TextStyle(
                                                color: HexColor('0f1923'),
                                                fontSize: 28,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
              // const SizedBox(height: 10),
              // FilterWeapons
              // SizedBox(
              //   width: size.width,
              //   height: 60,
              //   child: FutureBuilder(
              //     future: fetchWeapons(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         var weapons = snapshot.data!.data;
              //         return GridView.builder(
              //           itemCount: filterName.length,
              //           scrollDirection: Axis.horizontal,
              //           gridDelegate:
              //               const SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 1,
              //             mainAxisExtent: 100,
              //           ),
              //           itemBuilder: (context, index) {
              //             return InkResponse(
              //               onTap: () {
              //                 setState(() {
              //                   selectedWeaponIndex = 0;
              //                   selectedFilterIndex = index;
              //                   fillterWeapons = weapons
              //                       .where(
              //                         (element) =>
              //                             element.category
              //                                 .split('::')[1]
              //                                 .toLowerCase() ==
              //                             filterName[index],
              //                       )
              //                       .toList();
              //                   print(fillterWeapons.length);
              //                 });
              //               },
              //               child: Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: AnimatedContainer(
              //                   duration: const Duration(milliseconds: 500),
              //                   decoration: BoxDecoration(
              //                     color: selectedFilterIndex == index
              //                         ? filterColors[index]
              //                         : Colors.white,
              //                   ),
              //                   alignment: Alignment.center,
              //                   child: Text(
              //                     filterName[index],
              //                     style: const TextStyle(
              //                       fontSize: 19,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             );
              //           },
              //         );
              //       }
              //       return const Center(
              //         child: RiveAnimation.asset('assets/animation/wait.riv'),
              //       );
              //     },
              //   ),
              // ),
              // const SizedBox(height: 30),

              // Search Box
              // SizedBox(
              //   width: size.width - 40,
              //   child: Center(
              //     child: Stack(
              //       children: [
              //         SvgPicture.asset(
              //           height: 55,
              //           'assets/images/SearchBox.svg',
              //         ),
              //         const Positioned(
              //           top: 17,
              //           left: 10,
              //           child: Icon(
              //             Icons.search,
              //             color: Colors.white,
              //           ),
              //         ),
              //         Positioned(
              //           top: 15,
              //           left: 60,
              //           child: SizedBox(
              //             width: size.width,
              //             height: 30,
              //             child: TextFormField(
              //               controller: searchController,
              //               style: const TextStyle(color: Colors.white),
              //               decoration: const InputDecoration(
              //                 hintText: 'Search',
              //                 hintStyle: TextStyle(color: Colors.white),
              //                 border: InputBorder.none,
              //               ),
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),

              // Information
              // SizedBox(
              //   width: size.width - 30,
              //   child: FutureBuilder(
              //     future: fetchWeapons(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         var weapons = snapshot.data!.data;
              //         return InkResponse(
              //           onDoubleTap: () {
              //             setState(() {
              //               Navigator.pushNamed(context, '/DetailNewWeapon',
              //                   arguments: nextpage);
              //             });
              //           },
              //           onTap: () {
              //             setState(() {
              //               nextpage['data'] = fillterWeapons.isEmpty
              //                   ? weapons
              //                   : fillterWeapons;
              //               nextpage['index'] = selectedWeaponIndex;
              //             });
              //             print(nextpage);

              //             Navigator.pushNamed(context, '/weaponsDetail',
              //                 arguments: nextpage);
              //           },
              //           child: Stack(
              //             children: [
              //               // background Image
              //               SvgPicture.asset(
              //                 width: size.width,
              //                 'assets/images/info2.svg',
              //                 colorFilter: ColorFilter.mode(
              //                   weaponsColors[fillterWeapons.isEmpty
              //                           ? weapons[selectedWeaponIndex]
              //                               .category
              //                               .split('::')[1]
              //                               .toLowerCase()
              //                           : fillterWeapons[selectedWeaponIndex]
              //                               .category
              //                               .split('::')[1]
              //                               .toLowerCase()]!
              //                       .withOpacity(0.7),
              //                   BlendMode.srcIn,
              //                 ),
              //               ),
              //               // DisplayName
              //               Positioned(
              //                 top: 10,
              //                 right: 10,
              //                 child: Text(
              //                   fillterWeapons.isEmpty
              //                       ? weapons[selectedWeaponIndex].displayName
              //                       : fillterWeapons[selectedWeaponIndex]
              //                           .displayName,
              //                   style: const TextStyle(
              //                     fontSize: 27,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //               ),
              //               // Weapons Category
              //               Positioned(
              //                 top: 10,
              //                 left: 10,
              //                 child: Text(
              //                   fillterWeapons.isEmpty
              //                       ? weapons[selectedWeaponIndex]
              //                           .category
              //                           .split('::')[1]
              //                           .toLowerCase()
              //                       : fillterWeapons[selectedWeaponIndex]
              //                           .category
              //                           .split('::')[1]
              //                           .toLowerCase(),
              //                   style: const TextStyle(
              //                       fontSize: 27,
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.white54),
              //                 ),
              //               ),
              //               // Cost
              //               Positioned(
              //                 top: 60,
              //                 left: 10,
              //                 child: Row(
              //                   children: [
              //                     Text('Cost : ', style: detailStyle),
              //                     const SizedBox(width: 10),
              //                     Text(
              //                         fillterWeapons.isEmpty
              //                             ? weapons[selectedWeaponIndex]
              //                                         .displayName ==
              //                                     'Melee'
              //                                 ? '0'
              //                                 : weapons[selectedWeaponIndex]
              //                                     .shopData!
              //                                     .cost
              //                                     .toString()
              //                             : fillterWeapons[selectedWeaponIndex]
              //                                         .displayName ==
              //                                     'Melee'
              //                                 ? '0'
              //                                 : fillterWeapons[
              //                                         selectedWeaponIndex]
              //                                     .shopData!
              //                                     .cost
              //                                     .toString(),
              //                         style: detailStyle),
              //                   ],
              //                 ),
              //               ),
              //               // Fire Rate
              //               Positioned(
              //                 top: 95,
              //                 left: 10,
              //                 child: Row(
              //                   children: [
              //                     Text('Fire Rate :', style: detailStyle),
              //                     const SizedBox(width: 10),
              //                     Text(
              //                       fillterWeapons.isEmpty
              //                           ? weapons[selectedWeaponIndex]
              //                                       .displayName ==
              //                                   'Melee'
              //                               ? '0'
              //                               : weapons[selectedWeaponIndex]
              //                                   .weaponStats!
              //                                   .fireRate
              //                                   .toString()
              //                           : fillterWeapons[selectedWeaponIndex]
              //                                       .displayName ==
              //                                   'Melee'
              //                               ? '0'
              //                               : fillterWeapons[
              //                                       selectedWeaponIndex]
              //                                   .weaponStats!
              //                                   .fireRate
              //                                   .toString(),
              //                       style: detailStyle,
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               // Fire Rate slider
              //               Positioned(
              //                 top: 110,
              //                 child: SizedBox(
              //                   width: size.width - 30,
              //                   height: 60,
              //                   child: SliderTheme(
              //                     data: SliderThemeData(
              //                       thumbShape: SliderComponentShape.noThumb,
              //                       trackHeight: 10,
              //                       activeTrackColor: Colors.black,
              //                     ),
              //                     child: Slider(
              //                       max: 16,
              //                       min: 0,
              //                       value: fillterWeapons.isEmpty
              //                           ? weapons[selectedWeaponIndex]
              //                                       .weaponStats
              //                                       ?.fireRate ==
              //                                   null
              //                               ? 0.0
              //                               : double.parse(
              //                                   weapons[selectedWeaponIndex]
              //                                       .weaponStats!
              //                                       .fireRate
              //                                       .toString())
              //                           : fillterWeapons[selectedWeaponIndex]
              //                                       .weaponStats
              //                                       ?.fireRate ==
              //                                   null
              //                               ? 0.0
              //                               : double.parse(fillterWeapons[
              //                                       selectedWeaponIndex]
              //                                   .weaponStats!
              //                                   .fireRate
              //                                   .toString()),
              //                       onChanged: (value) {},
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               const Positioned(
              //                 bottom: 10,
              //                 left: 150,
              //                 child: Text(
              //                   'Click For More detail',
              //                   style: TextStyle(
              //                     color: Colors.white70,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         );
              //       }
              //       // Loading Data
              //       return SizedBox(
              //         height: 230,
              //         width: size.width - 30,
              //         child: Stack(
              //           children: [
              //             SvgPicture.asset(
              //               width: size.width,
              //               'assets/images/info2.svg',
              //               colorFilter: ColorFilter.mode(
              //                 Colors.yellow.withOpacity(0.7),
              //                 BlendMode.srcIn,
              //               ),
              //             ),
              //             const RiveAnimation.asset(
              //                 'assets/animation/wait.riv'),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
