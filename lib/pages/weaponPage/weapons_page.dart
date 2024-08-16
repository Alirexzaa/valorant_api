import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:valorant_api/api/dart_api.dart';
import 'package:valorant_api/model/weapons_model.dart';
import 'package:valorant_api/pages/constants.dart';

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
        backgroundColor: Constants.primaryColor,
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
            color: Constants.secondPrimaryColor,
            Icons.arrow_back_ios_outlined,
          ),
        ),
      ),
      backgroundColor: Constants.primaryColor,
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
                                  debugPrint(fillterWeapons.length.toString());
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
                                        ? Constants.secondPrimaryColor
                                        : Constants.primaryColor,
                                    border: Border.all(
                                      color: Constants.secondPrimaryColor,
                                    ),
                                  ),
                                  child: Text(
                                    filterName[index],
                                    style: TextStyle(
                                      color: filterSelectedInedx == index
                                          ? Constants.primaryColor
                                          : Constants.secondPrimaryColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Center(
                        child:
                            RiveAnimation.asset(Constants.loadingRiveAnimation),
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
                                  border: Border.all(
                                      color: Constants.secondPrimaryColor),
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
                                      color: Constants.secondPrimaryColor,
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
                                                color: Constants.primaryColor,
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
                                                color: Constants.primaryColor,
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
                    return Center(
                      child:
                          RiveAnimation.asset(Constants.loadingRiveAnimation),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
