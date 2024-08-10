import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:valorant_api/api/dart_api.dart';
import 'package:valorant_api/model/weapons_model.dart';

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
      backgroundColor: HexColor('0f1923'),
      body: FutureBuilder(
        future: fetchWeapons(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // var weaponData = snapshot.data!.data;
            return SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  // weapon picture
                  Container(
                    alignment: Alignment.topCenter,
                    width: size.width,
                    height: 447,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: -60,
                          top: -30,
                          bottom: -110,
                          child: SvgPicture.asset(
                            height: 500,
                            'assets/images/red_box.svg',
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Image.network(
                              weaponData[weaponIndex].displayIcon),
                        ),
// App Bar
                        Positioned(
                          top: 50,
                          left: 30,
                          child: IconButton(
                            iconSize: 30,
                            color: HexColor('e9404f'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        const Positioned(
                          top: 40,
                          left: 110,
                          child: Text(
                            'Weapon Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
// Details
                  Positioned(
                    bottom: 300,
                    top: 380,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DetailRow(
                          detail: weaponData[weaponIndex]
                              .category
                              .split('::')[1]
                              .toLowerCase(),
                          name: 'Type',
                        ),
                        Container(
                          width: size.width - 50,
                          height: 1,
                          color: Colors.white,
                        ),
                        DetailRow(
                          detail:
                              weaponData[weaponIndex].shopData!.cost.toString(),
                          name: 'Creds',
                        ),
                        Container(
                          width: size.width - 50,
                          height: 1,
                          color: Colors.white,
                        ),
                        DetailRow(
                          detail: weaponData[weaponIndex]
                              .weaponStats!
                              .magazineSize
                              .toString(),
                          name: 'Magazine',
                        ),
                        Container(
                          width: size.width - 50,
                          height: 1,
                          color: Colors.white,
                        ),
                        DetailRow(
                          detail: weaponData[weaponIndex]
                              .weaponStats!
                              .fireRate
                              .toString(),
                          name: 'FireRate',
                        ),
                        Container(
                          width: size.width - 50,
                          height: 1,
                          color: Colors.white,
                        ),
                        DetailRow(
                          detail: weaponData[weaponIndex]
                              .weaponStats!
                              .damageRanges[0]
                              .headDamage
                              .toString(),
                          name: 'HeadDamage',
                        ),
                        Container(
                          width: size.width - 50,
                          height: 1,
                          color: Colors.white,
                        ),
                        DetailRow(
                          detail: weaponData[weaponIndex]
                              .weaponStats!
                              .damageRanges[0]
                              .bodyDamage
                              .toString(),
                          name: 'BodyDamage',
                        ),
                        Container(
                          width: size.width - 50,
                          height: 1,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
// Skins
                  Positioned(
                    bottom: 230,
                    left: 10,
                    child: Text(
                      'Skins : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: HexColor('ff4655'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      width: size.width,
                      height: 190,
                      child: GridView.builder(
                        itemCount: weaponData[weaponIndex].skins.length,
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 360,
                          crossAxisCount: 1,
                        ),
                        itemBuilder: (context, index) {
                          return weaponData[weaponIndex]
                                      .skins[index]
                                      .displayIcon !=
                                  null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 220,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: HexColor('ff4655')),
                                    ),
                                    child: Image.network(
                                      weaponData[weaponIndex]
                                          .skins[index]
                                          .displayIcon
                                          .toString(),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 220,
                                    height: 60,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: HexColor('ff4655')),
                                    ),
                                    child: Text(
                                      'Not Available',
                                      style: TextStyle(
                                          fontSize: 50,
                                          color: HexColor('ff4655')
                                              .withOpacity(0.5)),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  const DetailRow({
    super.key,
    required this.name,
    required this.detail,
  });

  final String name;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 30, color: HexColor('e9404f')),
          ),
          Text(
            detail,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
