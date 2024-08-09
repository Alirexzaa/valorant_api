import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant_api/api/dart_api.dart';
import 'package:valorant_api/model/agents_model.dart';
import 'package:valorant_api/model/maps_model.dart';
import 'package:animations/animations.dart';
import 'package:valorant_api/pages/agentPage/agent_page.dart';
import 'package:valorant_api/pages/bundlesPage/bundles_page.dart';
import 'package:valorant_api/pages/mapPage/map_page.dart';
import 'package:valorant_api/pages/weaponPage/weapons_page.dart';

class NewHomePage extends StatefulWidget {
  static String routeName = '/HomePage';

  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  // local var
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int bottomNavigationBarindex = 1;
  int selecteditem = 0;
  int searchIndex = 0;
  TextEditingController searchString = TextEditingController();
  List<String> filtersName = ['Agents', 'Maps'];
  late String name = '';
  String emailCheck = '';
  String paswordCheck = '';
  late int imageIndex = 0;
  String agentBackgroundColor = 'e9404f';

  Future<void> _readData() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('username') ?? '';
    emailCheck = prefs.getString('email') ?? '';
    paswordCheck = prefs.getString('password') ?? '';
    imageIndex = prefs.getInt('imageIndex') ?? 0;
  }

  @override
  void initState() {
    _readData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // GET SIZE OF DISPLAY IN USE
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('e9404f'),
      // App bar
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: HexColor('e9404f'),
        title: const Text(
          'HomePage',
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
          backgroundColor: HexColor('e9404f'),
          key: _scaffoldKey,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  SizedBox(
                    width: size.width,
                    height: 400,
                    child: FutureBuilder(
                      future: fetchAgents(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var agentData = snapshot.data!.data;
                          agentBackgroundColor =
                              agentData[imageIndex].backgroundGradientColors[0];
                          return Container(
                            color: HexColor(
                                    removeLastCharacter(agentBackgroundColor))
                                .withOpacity(0.9),
                            child: Image.network(
                                agentData[imageIndex].fullPortrait.toString()),
                          );
                        }
                        return const Center(
                          child:
                              RiveAnimation.asset('assets/animation/wait.riv'),
                        );
                      },
                    ),
                  ),
                  customDetailWidget('name', name),
                  customDetailWidget('Email', emailCheck),
                  customDetailWidget('Password', paswordCheck),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/SpraysPag');
                      },
                      child: const Text('Sprays')),
                ],
              );
            },
          )),
      // body
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text('width ${size.width.round()} height ${size.height.round()}'),
              CustomInkResposne(
                size: size,
                pagename: const NewAgentPage(),
                assetDir: 'assets/images/fullportrait.png',
                name: 'Agents',
              ),
              const SizedBox(height: 30),
              CustomInkResposne(
                size: size,
                pagename: const MapPage(),
                assetDir: 'assets/images/map.png',
                name: 'Maps',
              ),
              // const SizedBox(height: 30),
              // CustomInkResposne(
              //   size: size,
              //   pagename: const NewAgentPage(),
              //   assetDir: 'assets/images/fullportrait.png',
              //   name: 'OldAgents',
              // ),
              const SizedBox(height: 30),
              CustomInkResposne(
                size: size,
                pagename: const WeaponsPage(),
                assetDir: 'assets/images/weapon.png',
                name: 'Weapons',
              ),
              const SizedBox(height: 30),

              CustomInkResposne(
                size: size,
                pagename: const BundlesPage(),
                assetDir: 'assets/images/fullportrait.png',
                name: 'Bundles',
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      // Search Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        splashColor: HexColor('e9404f'),
        shape: const RoundedRectangleBorder(),
        child: Icon(
          Icons.search,
          color: HexColor('e9404f'),
        ),
        onPressed: () {
          setState(
            () {
              showModalBottomSheet(
                showDragHandle: true,
                backgroundColor: HexColor('e9404f'),
                shape: const RoundedRectangleBorder(),
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        width: size.width,
                        height: size.height - 100,
                        color: HexColor('e9404f'),
                        child: Column(
                          children: [
                            // Filters
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Filters',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                  ),
                                  SizedBox(
                                    height: 60,
                                    width: 300,
                                    child: AnimatedGrid(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1),
                                      initialItemCount: 2,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index, animation) {
                                        return InkResponse(
                                          splashColor: HexColor('e9404f'),
                                          onTap: () {
                                            setState(() {
                                              searchIndex = index;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: searchIndex == index
                                                      ? Colors.black
                                                      : HexColor('e9404f'),
                                                  border: Border.all()),
                                              child: Text(
                                                filtersName[index],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                      height: 55,
                                      'assets/images/SearchBox.svg'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30.0),
                                  child: Center(
                                    child: TextFormField(
                                      controller: searchString,
                                      onChanged: (value) {
                                        setState(() {
                                          searchString.text = value;
                                        });
                                      },
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Search',
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            searchIndex == 0
                                ? searchNewAgents(size)
                                : searchMaps(size),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Padding customDetailWidget(
    String lable,
    String category,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15.0, bottom: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              lable,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            width: 270,
            height: 60,
            decoration: BoxDecoration(color: Colors.black, boxShadow: [
              BoxShadow(
                offset: const Offset(10, 10),
                blurRadius: 10.0,
                color: HexColor(removeLastCharacter(agentBackgroundColor)),
              ),
            ]),
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Search Method for find and show maps with names
  FutureBuilder<Maps> searchMaps(Size size) {
    return FutureBuilder(
      future: fetchMaps(),
      builder: (context, snapshot) {
        var mapdata = snapshot.data;
        if (snapshot.hasData) {
          return Expanded(
            child: AnimatedList(
              initialItemCount: mapdata!.data.length,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                return mapdata.data[index].displayName
                        .toLowerCase()
                        .contains(searchString.text.toLowerCase())
                    ? Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        width: size.width - 5,
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                                width: size.width - 100,
                                'assets/images/searchContent.svg'),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Image.network(
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                      'assets/images/SmallAgent.png');
                                },
                                height: 120,
                                mapdata.data[index].displayIcon.toString(),
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 30,
                              child: Text(
                                mapdata.data[index].displayName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox();
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  // Search method for find and show agent with name
  FutureBuilder<Agents> searchNewAgents(Size size) {
    return FutureBuilder(
      future: fetchAgents(),
      builder: (context, snapshot) {
        var agentDatas = snapshot.data;
        if (snapshot.hasData) {
          return Expanded(
            child: AnimatedList(
              initialItemCount: agentDatas!.data.length,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                return agentDatas.data[index].displayName
                            .toLowerCase()
                            .contains(searchString.text.toLowerCase()) &&
                        agentDatas.data[index].isPlayableCharacter
                    ? InkResponse(
                        onTap: () {
                          Navigator.pushNamed(context, '/AgentDetail',
                              arguments: index);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          width: size.width - 5,
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                  width: size.width - 100,
                                  'assets/images/searchContent.svg'),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Image.network(
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/SmallAgent.png');
                                  },
                                  height: 120,
                                  agentDatas.data[index].displayIcon,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 30,
                                child: Text(
                                  agentDatas.data[index].displayName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox();
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  // DELETE 2 CHARACTER FROM LAST STRING
  String removeLastCharacter(String input) {
    return input.substring(0, input.length - 2);
  }
}

// A custom widget from InkResposne get pagename, assets, name,
class CustomInkResposne extends StatelessWidget {
  const CustomInkResposne({
    super.key,
    required this.size,
    required this.pagename,
    required this.assetDir,
    required this.name,
  });

  final Size size;
  final Widget pagename;
  final String assetDir;
  final String name;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: HexColor('e9404f'),
      // clipBehavior: Clip.none,
      closedElevation: 0.0,
      // closedShape:
      //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      middleColor: HexColor('e9404f'),
      transitionDuration: const Duration(milliseconds: 350),
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (context, action) {
        return InkResponse(
          // onTap: () {
          //   Navigator.pushNamed(context, pagename);
          // },
          child: Container(
            alignment: Alignment.center,
            width: 500,
            height: 210,
            child: Stack(
              children: [
                SvgPicture.asset(
                  width: size.width,
                  'assets/images/blackBox.svg',
                ),
                Image.asset(
                  fit: BoxFit.cover,
                  assetDir,
                ),
                Positioned(
                  top: 70,
                  bottom: 0,
                  right: 50,
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      openBuilder: (context, action) => pagename,
    );
  }
}
