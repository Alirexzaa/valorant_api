import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart' as rive;
import 'package:valorant_api/api/dart_api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:valorant_api/pages/constants.dart';
import 'package:valorant_api/pages/tools.dart';

class NewAgentPage extends StatefulWidget {
  static String routeName = '/NewAgentPage';
  const NewAgentPage({super.key});

  @override
  State<NewAgentPage> createState() => _NewAgentPageState();
}

class _NewAgentPageState extends State<NewAgentPage> {
  int selecteditem = 0;
  int searchIndex = 0;
  TextEditingController searchBoxString = TextEditingController();
  List agentGradientsList = ["c7f458ff", "d56324ff", "3a2656ff", "3a7233ff"];
  List searchData = [];

  PageController agentPageView = PageController();
  CarouselController carouselController = CarouselController();
  ScrollController animatedGridAgent = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.5,
            colors: [
              HexColor(
                  '#${removeLastCharacter(agentGradientsList[0].toString())}'),
              HexColor(
                  '#${removeLastCharacter(agentGradientsList[1].toString())}'),
              HexColor(
                  '#${removeLastCharacter(agentGradientsList[2].toString())}'),
              HexColor(
                  '#${removeLastCharacter(agentGradientsList[3].toString())}'),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              // App Bar
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 50,
                        color: Constants.secondPrimaryColor,
                      ),
                    ),
                    Text(
                      'AGENTS',
                      style: TextStyle(
                          color: Constants.secondPrimaryColor,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Agent fullPortrait
              SizedBox(
                width: size.width,
                height: 550,
                child: FutureBuilder(
                  future: fetchAgents(),
                  builder: (context, snapshot) {
                    var agentDatas = snapshot.data;
                    if (snapshot.hasData) {
                      return PageView.builder(
                        controller: agentPageView,
                        onPageChanged: (value) {
                          setState(() {
                            selecteditem = value;
                            carouselController.jumpToPage(value);
                          });
                        },
                        itemCount: agentDatas!.data.length,
                        itemBuilder: (context, index) {
                          return agentDatas.data[index].isPlayableCharacter
                              ? InkResponse(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/AgentDetail',
                                        arguments: selecteditem);
                                  },
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: SvgPicture.asset(
                                          height: 500,
                                          Constants.bigBlackPicture,
                                        ),
                                      ),
                                      Center(
                                        child: Image.network(
                                          height: 500,
                                          filterQuality: FilterQuality.high,
                                          scale: 5,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                          color: Colors.grey.withOpacity(0.5),
                                          agentDatas.data[index].background
                                              .toString(),
                                        ),
                                      ),
                                      Center(
                                        child: Image.network(
                                          height: 500,
                                          filterQuality: FilterQuality.high,
                                          scale: 5,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                          agentDatas.data[index].fullPortrait
                                              .toString(),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 10,
                                        right: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30.0, right: 30.0),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 50,
                                            width: size.width,
                                            color: Colors.red.withOpacity(0.5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                    width: 50,
                                                    color: Colors.black,
                                                    child: const Icon(
                                                      Icons.info_outline,
                                                      color: Colors.white,
                                                      size: 50,
                                                    )),
                                                Container(
                                                  width: 50,
                                                  color: HexColor(
                                                    removeLastCharacter(
                                                      agentDatas
                                                          .data[index]
                                                          .backgroundGradientColors[
                                                              0]
                                                          .toString(),
                                                    ),
                                                  ),
                                                  child: Image.network(
                                                    agentDatas
                                                        .data[index]
                                                        .abilities[0]
                                                        .displayIcon
                                                        .toString(),
                                                  ),
                                                ),
                                                Container(
                                                  width: 50,
                                                  color: HexColor(
                                                    removeLastCharacter(
                                                      agentDatas
                                                          .data[index]
                                                          .backgroundGradientColors[
                                                              1]
                                                          .toString(),
                                                    ),
                                                  ),
                                                  child: Image.network(
                                                    agentDatas
                                                        .data[index]
                                                        .abilities[1]
                                                        .displayIcon
                                                        .toString(),
                                                  ),
                                                ),
                                                Container(
                                                  width: 50,
                                                  color: HexColor(
                                                    removeLastCharacter(
                                                      agentDatas
                                                          .data[index]
                                                          .backgroundGradientColors[
                                                              2]
                                                          .toString(),
                                                    ),
                                                  ),
                                                  child: Image.network(
                                                    agentDatas
                                                        .data[index]
                                                        .abilities[2]
                                                        .displayIcon
                                                        .toString(),
                                                  ),
                                                ),
                                                Container(
                                                  width: 50,
                                                  color: HexColor(
                                                    removeLastCharacter(
                                                      agentDatas
                                                          .data[index]
                                                          .backgroundGradientColors[
                                                              3]
                                                          .toString(),
                                                    ),
                                                  ),
                                                  child: Image.network(
                                                    agentDatas
                                                        .data[index]
                                                        .abilities[3]
                                                        .displayIcon
                                                        .toString(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox();
                        },
                      );
                    }
                    return Stack(
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            height: 500,
                            Constants.bigBlackPicture,
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(40.0),
                            child: rive.RiveAnimation.asset(
                                Constants.loadingRiveAnimation),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Search Box
              SizedBox(
                width: 500,
                height: 60,
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: size.width - 30,
                        height: 55,
                        child: SvgPicture.asset(Constants.searchBoxPicture),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50.0, top: 3.0),
                        child: TextField(
                          controller: searchBoxString,
                          onChanged: (value) {
                            setState(() {
                              searchBoxString.text = value;
                            });
                          },
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Agent List
              FutureBuilder(
                future: fetchAgents(),
                builder: (context, snapshot) {
                  var agentDatas = snapshot.data;
                  if (snapshot.hasData) {
                    return SizedBox(
                        width: size.width,
                        height: searchBoxString.text.isEmpty ? 170 : 220,
                        child: searchBoxString.text.isEmpty
                            ? CarouselSlider.builder(
                                carouselController: carouselController,
                                options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  viewportFraction: 0.4,
                                  animateToClosest: false,
                                ),
                                itemCount: agentDatas!.data.length,
                                itemBuilder: (context, index, realIndex) {
                                  return agentDatas.data[index].displayName
                                          .toLowerCase()
                                          .contains(searchBoxString.text
                                              .toLowerCase())
                                      ? agentDatas
                                              .data[index].isPlayableCharacter
                                          ? InkResponse(
                                              onTap: () {
                                                setState(() {
                                                  selecteditem = index;
                                                  agentGradientsList = agentDatas
                                                      .data[index]
                                                      .backgroundGradientColors;
                                                  agentPageView
                                                      .jumpToPage(index);
                                                });
                                              },
                                              child: Stack(
                                                children: [
                                                  selecteditem == index
                                                      ? SvgPicture.asset(Constants
                                                          .selectedBoxPicture)
                                                      : SvgPicture.asset(
                                                          Constants.boxPicture),
                                                  Positioned(
                                                    right: 10,
                                                    bottom: 25,
                                                    child: Image.network(
                                                      height: 120,
                                                      agentDatas.data[index]
                                                          .displayIcon,
                                                      filterQuality:
                                                          FilterQuality.high,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 57,
                                                    bottom: 0,
                                                    child: Text(
                                                      agentDatas.data[index]
                                                          .displayName,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Stack(
                                              children: [
                                                SvgPicture.asset(
                                                    Constants.boxPicture),
                                                Positioned(
                                                  right: 10,
                                                  bottom: 25,
                                                  child: Image.network(
                                                    color: Colors.amber,
                                                    height: 120,
                                                    agentDatas.data[index]
                                                        .displayIcon,
                                                    filterQuality:
                                                        FilterQuality.high,
                                                  ),
                                                ),
                                                const Positioned(
                                                  right: 30,
                                                  bottom: 0,
                                                  child: Text(
                                                    'NotAvailable',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            )
                                      : const SizedBox();
                                },
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(0),
                                itemCount: agentDatas!.data.length,
                                itemBuilder: (context, index) {
                                  return agentDatas.data[index].displayName
                                          .toLowerCase()
                                          .contains(searchBoxString.text
                                              .toLowerCase())
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/AgentDetail',
                                                  arguments: index);
                                            },
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: SvgPicture.asset(
                                                      height: 220,
                                                      Constants
                                                          .blackBoxPicture),
                                                ),
                                                Positioned(
                                                  bottom: 30,
                                                  right: 20,
                                                  child: Image.network(
                                                      height: 160,
                                                      agentDatas.data[index]
                                                          .displayIcon),
                                                ),
                                                Positioned(
                                                  top: 30,
                                                  left: 20,
                                                  child: Text(
                                                    agentDatas.data[index]
                                                        .displayName,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 23,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 60,
                                                  left: 20,
                                                  child: SizedBox(
                                                    width: 110,
                                                    child: Text(
                                                      agentDatas
                                                          .data[index]
                                                          .role!
                                                          .displayName
                                                          .name,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 23,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 60,
                                                  left: 20,
                                                  child: SizedBox(
                                                    width: 110,
                                                    child: Image.network(
                                                        height: 60,
                                                        agentDatas.data[index]
                                                            .role!.displayIcon),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              ));
                  }
                  return SizedBox(
                    width: size.width,
                    height: 170,
                    child: GridView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                height: 170,
                                Constants.boxPicture,
                              ),
                              Positioned(
                                top: 40,
                                bottom: 30,
                                left: 40,
                                right: 30,
                                child: rive.RiveAnimation.asset(
                                    Constants.loadingRiveAnimation),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
