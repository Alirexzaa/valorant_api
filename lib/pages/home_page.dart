import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant_api/api/dart_api.dart';
import 'package:valorant_api/pages/agentPage/agent_page.dart';
import 'package:valorant_api/pages/bundlesPage/bundles_page.dart';
import 'package:valorant_api/pages/constants.dart';
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
  late int imageIndex = 0;
  int searchIndex = 0;
  TextEditingController searchString = TextEditingController();
  TextEditingController editName = TextEditingController();
  TextEditingController editEmail = TextEditingController();
  TextEditingController editPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String agentBackgroundColor = 'e9404f';
  late String name = '';
  String emailCheck = '';
  String paswordCheck = '';
  List<String> filtersName = ['Agents', 'Maps'];

  // Start methods for SharedPreferences

  // write method for SharedPreferences
  Future<void> _writeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', editName.text);
    await prefs.setString('email', editEmail.text);
    await prefs.setString('password', editPassword.text);
    await prefs.setInt('imageIndex', imageIndex);
    _readData();
  }

  // read method for SharedPreferences
  Future<void> _readData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('username') ?? '';
      emailCheck = prefs.getString('email') ?? '';
      paswordCheck = prefs.getString('password') ?? '';
      imageIndex = prefs.getInt('imageIndex') ?? 0;
    });
  }
// End methods for SharedPreferences

  @override
  void initState() {
    super.initState();
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    // GET SIZE OF DISPLAY IN USE
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Constants.primaryColor,
        // Drawer
        drawer: customDrawer(size),
        // App bar
        appBar: AppBar(
          leading: IconButton(
            color: Constants.secondPrimaryColor,
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
          backgroundColor: Constants.primaryColor,
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
                  assetDir: Constants.agentPicure,
                  name: 'Agents',
                  imageHeight: 150,
                ),
                const SizedBox(height: 30),
                CustomInkResposne(
                  size: size,
                  pagename: const WeaponsPage(),
                  assetDir: Constants.weaponPicure,
                  name: 'Weapons',
                  imageHeight: 110,
                ),
                const SizedBox(height: 30),
                CustomInkResposne(
                  size: size,
                  pagename: const BundlesPage(),
                  assetDir: Constants.bundlesPicure,
                  name: 'Bundles',
                  imageHeight: 140,
                ),
                const SizedBox(height: 30),
                CustomInkResposne(
                  size: size,
                  pagename: const MapPage(),
                  assetDir: Constants.mapPicure,
                  name: 'Maps',
                  imageHeight: 150,
                ),
              ],
            ),
          ),
        ),
        // Search Button
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          splashColor: Constants.secondPrimaryColor,
          shape: const RoundedRectangleBorder(),
          child: Icon(
            Icons.search,
            color: Constants.secondPrimaryColor,
          ),
          onPressed: () {
            setState(
              () {
                customBottonSheet(context, size);
              },
            );
          },
        ));
  }

  Future<dynamic> customBottonSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Constants.primaryColor,
      shape: const RoundedRectangleBorder(),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: size.width,
              height: size.height - 100,
              color: Constants.primaryColor,
              child: Column(
                children: [
                  // Filters
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            itemBuilder: (context, index, animation) {
                              return InkResponse(
                                splashColor: Constants.primaryColor,
                                onTap: () {
                                  setState(() {
                                    searchIndex = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: AnimatedContainer(
                                    duration: const Duration(
                                      milliseconds: 500,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: searchIndex == index
                                          ? Constants.secondPrimaryColor
                                          : Constants.primaryColor,
                                      border: Border.all(
                                        color: searchIndex == index
                                            ? Constants.primaryColor
                                            : Constants.secondPrimaryColor,
                                      ),
                                    ),
                                    child: Text(
                                      filtersName[index],
                                      style: TextStyle(
                                        color: searchIndex == index
                                            ? Constants.primaryColor
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
                            height: 55, 'assets/images/SearchBox.svg'),
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
                                color: Constants.secondPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  searchIndex == 0
                      ? SearchAgents(searchString: searchString, size: size)
                      : SearchMaps(searchString: searchString, size: size)
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Drawer
  Drawer customDrawer(Size size) {
    return Drawer(
      backgroundColor: Constants.primaryColor,
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
                        agentBackgroundColor =
                            agentData[imageIndex].backgroundGradientColors[0];
                        return Column(
                          children: [
                            Container(
                              color: HexColor(
                                      removeLastCharacter(agentBackgroundColor))
                                  .withOpacity(0.9),
                              child: Image.network(
                                agentData[imageIndex].fullPortrait.toString(),
                              ),
                            ),
                            CustomInformationBox(
                                category: name,
                                lable: 'name',
                                agentBackgroundColor: agentBackgroundColor,
                                size: size),
                            CustomInformationBox(
                                category: emailCheck,
                                lable: 'Email',
                                agentBackgroundColor: agentBackgroundColor,
                                size: size),
                            CustomInformationBox(
                                category: paswordCheck,
                                lable: 'Password',
                                agentBackgroundColor: agentBackgroundColor,
                                size: size),
                            const SizedBox(height: 30),
                            InkResponse(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Constants.primaryColor
                                          .withOpacity(0.9),
                                      child: SizedBox(
                                        width: size.width,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: CustomTextFormField(
                                                  size: size,
                                                  nameController: editName,
                                                  name: 'Name',
                                                  regex: Constants.nameReGex,
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
                                                    const EdgeInsets.all(15.0),
                                                child: CustomTextFormField(
                                                  size: size,
                                                  nameController: editEmail,
                                                  name: 'Email',
                                                  regex: Constants.emailReGex,
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
                                                    const EdgeInsets.all(15.0),
                                                child: CustomTextFormField(
                                                  size: size,
                                                  nameController: editPassword,
                                                  name: 'Password',
                                                  regex:
                                                      Constants.passWordReGex,
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
                                                  alignment: Alignment.center,
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
                                                      Navigator.pop(context);
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
                                  color: Constants.primaryColor,
                                  border: Border.all(
                                    color: Constants.secondPrimaryColor,
                                  ),
                                ),
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Constants.secondPrimaryColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Center(
                        child:
                            RiveAnimation.asset(Constants.loadingRiveAnimation),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
