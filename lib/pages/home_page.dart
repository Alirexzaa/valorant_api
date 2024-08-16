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
import 'package:valorant_api/pages/tools.dart';
import 'package:valorant_api/pages/weaponPage/weapons_page.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/HomePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // local var
  int bottomNavigationBarindex = 1;
  int selecteditem = 0;
  int searchIndex = 0;
  TextEditingController searchString = TextEditingController();
  TextEditingController editName = TextEditingController();
  TextEditingController editEmail = TextEditingController();
  TextEditingController editPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> filtersName = ['Agents', 'Maps'];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String agentBackgroundColor = 'e9404f';
  late int imageIndex = 0;
  late String name = '';
  String emailCheck = '';
  String paswordCheck = '';
  Future<void> _writeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', editName.text);
    await prefs.setString('email', editEmail.text);
    await prefs.setString('password', editPassword.text);
    await prefs.setInt('imageIndex', imageIndex);
    _readData();
  }

  Future<void> _readData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('username') ?? '';
      emailCheck = prefs.getString('email') ?? '';
      paswordCheck = prefs.getString('password') ?? '';
      imageIndex = prefs.getInt('imageIndex') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _readData();
  }

  Padding customDetailWidget(
    String lable,
    String category,
    String agentBackgroundColor,
    Size size,
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
            width: size.width / 1.7,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: HexColor(removeLastCharacter(agentBackgroundColor)),
              ),
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(10, 10),
                  blurRadius: 10.0,
                  color: HexColor(removeLastCharacter(agentBackgroundColor)),
                ),
              ],
            ),
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              lable == 'Password' ? '*********' : category,
              style: TextStyle(
                color: HexColor('e9404f'),
                fontSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // GET SIZE OF DISPLAY IN USE
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor('0f1923'),
        // Drawer
        drawer: Drawer(
          backgroundColor: HexColor('0f1923'),
          child: FutureBuilder(
            future: fetchAgents(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height,
                      child: FutureBuilder(
                        future: fetchAgents(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var agentData = snapshot.data!.data;
                            agentBackgroundColor = agentData[imageIndex]
                                .backgroundGradientColors[0];
                            return Column(
                              children: [
                                Container(
                                  color: HexColor(removeLastCharacter(
                                          agentBackgroundColor))
                                      .withOpacity(0.9),
                                  child: Image.network(
                                    agentData[imageIndex]
                                        .fullPortrait
                                        .toString(),
                                  ),
                                ),
                                customDetailWidget(
                                    'name', name, agentBackgroundColor, size),
                                customDetailWidget('Email', emailCheck,
                                    agentBackgroundColor, size),
                                customDetailWidget('Password', paswordCheck,
                                    agentBackgroundColor, size),
                                const SizedBox(height: 30),
                                InkResponse(
                                  onTap: () {
                                    // Navigator.pushNamed(context, '/SignupPage');

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: HexColor('0f1923')
                                              .withOpacity(0.9),
                                          child: SizedBox(
                                            width: size.width,
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: CustomTextFormField(
                                                      size: size,
                                                      nameController: editName,
                                                      name: 'Name',
                                                      regex:
                                                          r'([a-zA-Z0-9_\s]+)',
                                                      error:
                                                          'please enter a vaild name',
                                                      backColor:
                                                          removeLastCharacter(
                                                        agentData[imageIndex]
                                                            .backgroundGradientColors[0],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: CustomTextFormField(
                                                      size: size,
                                                      nameController: editEmail,
                                                      name: 'Email',
                                                      regex:
                                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                                      error:
                                                          'Please enter a valid email address',
                                                      backColor:
                                                          removeLastCharacter(
                                                        agentData[imageIndex]
                                                            .backgroundGradientColors[0],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: CustomTextFormField(
                                                      size: size,
                                                      nameController:
                                                          editPassword,
                                                      name: 'Password',
                                                      regex:
                                                          r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$',
                                                      error:
                                                          'Please enter a valid Password',
                                                      backColor:
                                                          removeLastCharacter(
                                                        agentData[imageIndex]
                                                            .backgroundGradientColors[0],
                                                      ),
                                                    ),
                                                  ),
                                                  InkResponse(
                                                    splashColor: HexColor(
                                                      removeLastCharacter(
                                                        agentData[imageIndex]
                                                            .backgroundGradientColors[0],
                                                      ),
                                                    ),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 150,
                                                      height: 60,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.black,
                                                      ),
                                                      child: const Text(
                                                        'Done',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 23,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        setState(() {
                                                          debugPrint('worked');
                                                          _writeData();
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 150,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: HexColor('0f1923'),
                                      border: Border.all(
                                        color: HexColor('e9404f'),
                                      ),
                                    ),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: HexColor('e9404f'),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return const Center(
                            child: RiveAnimation.asset(
                                'assets/animation/wait.riv'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // App bar
        appBar: AppBar(
          leading: IconButton(
            color: HexColor('e9404f'),
            onPressed: () {
              if (_scaffoldKey.currentState != null) {
                _scaffoldKey.currentState!.openDrawer();
              }
            },
            icon: const Icon(
              Icons.people,
            ),
          ),
          toolbarHeight: 70,
          backgroundColor: HexColor('0f1923'),
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

        // body
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                    'width ${size.width.round()} height ${size.height.round()}'),
                CustomInkResposne(
                  size: size,
                  pagename: const NewAgentPage(),
                  assetDir: 'assets/images/13.png',
                  name: 'Agents',
                ),
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
                  assetDir: 'assets/images/b1.png',
                  name: 'Bundles',
                ),
                const SizedBox(height: 30),
                CustomInkResposne(
                  size: size,
                  pagename: const MapPage(),
                  assetDir: 'assets/images/map.png',
                  name: 'Maps',
                ),
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
                  backgroundColor: HexColor('0f1923'),
                  shape: const RoundedRectangleBorder(),
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Container(
                          width: size.width,
                          height: size.height - 100,
                          color: HexColor('0f1923'),
                          child: Column(
                            children: [
                              // Filters
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Filters',
                                      style: TextStyle(
                                        color: HexColor('ff4655'),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                      ),
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
                                        itemBuilder:
                                            (context, index, animation) {
                                          return InkResponse(
                                            splashColor: HexColor('0f1923'),
                                            onTap: () {
                                              setState(() {
                                                searchIndex = index;
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: AnimatedContainer(
                                                duration: const Duration(
                                                  milliseconds: 500,
                                                ),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: searchIndex == index
                                                      ? HexColor('e9404f')
                                                      : HexColor('0f1923'),
                                                  border: Border.all(
                                                    color: searchIndex == index
                                                        ? HexColor('0f1923')
                                                        : HexColor('e9404f'),
                                                  ),
                                                ),
                                                child: Text(
                                                  filtersName[index],
                                                  style: TextStyle(
                                                    color: searchIndex == index
                                                        ? HexColor('0f1923')
                                                        : Colors.red,
                                                  ),
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
                                      left: 30.0,
                                      right: 30.0,
                                    ),
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
                                        decoration: InputDecoration(
                                          icon: const Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Search',
                                          hintStyle: TextStyle(
                                            color: HexColor('e9404f'),
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
                                  : searchMaps(size)
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
        ));
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
}

// DELETE 2 CHARACTER FROM LAST STRING
String removeLastCharacter(String input) {
  return input.substring(0, input.length - 2);
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OpenContainer(
        closedColor: HexColor('141e29'),
        // clipBehavior: Clip.none,
        closedElevation: 0.0,
        // closedShape:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        middleColor: HexColor('141e29'),
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
              decoration: BoxDecoration(
                border: Border.all(color: HexColor('ff4655')),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Stack(
                      children: [
                        SvgPicture.asset(
                          height: 200,
                          'assets/images/agentBack.svg',
                        ),
                        Positioned(
                          right: 35,
                          bottom: 40,
                          child: Image.asset(
                            width: 140,
                            fit: BoxFit.fitWidth,
                            assetDir,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        openBuilder: (context, action) => pagename,
      ),
    );
  }
}
