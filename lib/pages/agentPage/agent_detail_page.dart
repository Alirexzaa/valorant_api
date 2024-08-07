// import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:valorant_api/api/dart_api.dart';
import 'package:rive/rive.dart' as rive;

class AgentDetail extends StatefulWidget {
  static String routeName = '/AgentDetail';
  const AgentDetail({super.key});

  @override
  State<AgentDetail> createState() => _DetailState();
}

class _DetailState extends State<AgentDetail> {
  // LOCAL ARTIB
  int selecteditem = 4;
  List<String> info = ['C', 'Q', 'E', 'X'];
  ScrollController mainController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // GET SIZE OF DISPLAY IN USE
    Size size = MediaQuery.of(context).size;
    // GET ARGUMENTS FROM LAST PAGE
    final int agentIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: FutureBuilder(
          future: fetchAgents(),
          builder: (context, snapshot) {
            var agent = snapshot.data;
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 1.5,
                    colors: [
                      HexColor(
                          '#${removeLastCharacter(agent!.data[agentIndex].backgroundGradientColors[0].toString())}'),
                      HexColor(
                          '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[1].toString())}'),
                      HexColor(
                          '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[2].toString())}'),
                      HexColor(
                          '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[3].toString())}'),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // AGENT PIC
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width,
                        height: size.height,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: size.width,
                              height: size.height,
                              child: Opacity(
                                opacity: 0.3,
                                child: Image.network(
                                    filterQuality: FilterQuality.high,
                                    scale: 0.5,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    agent.data[agentIndex].background
                                        .toString()),
                              ),
                            ),
                            SizedBox(
                              width: size.width,
                              height: size.height,
                              child: Image.network(
                                  filterQuality: FilterQuality.high,
                                  scale: 2,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  agent.data[agentIndex].fullPortrait
                                      .toString()),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ABILITIES
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkResponse(
                                  onTap: () {
                                    setState(() {
                                      selecteditem = 4;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: selecteditem == 4
                                            ? HexColor(
                                                '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[0].toString())}')
                                            : HexColor(
                                                    '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[0].toString())}')
                                                .withOpacity(0.5)),
                                    child: const Text(
                                      'info',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width - 80,
                                height: 90,
                                child: AnimatedGrid(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200),
                                  initialItemCount: 4,
                                  itemBuilder: (BuildContext context, int index,
                                      Animation<double> animation) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkResponse(
                                          onTap: () {
                                            setState(() {
                                              selecteditem = index;
                                            });
                                          },
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                right: 0,
                                                left: 0,
                                                child: SvgPicture.asset(
                                                    'assets/images/abilities.svg'),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 5,
                                                right: 5,
                                                child: Container(
                                                  width: 60,
                                                  height: 40,
                                                  color: selecteditem == index
                                                      ? HexColor(
                                                          '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[index].toString())}')
                                                      : HexColor(
                                                              '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[index].toString())}')
                                                          .withOpacity(0.6),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Image.network(
                                                      agent
                                                          .data[agentIndex]
                                                          .abilities[index]
                                                          .displayIcon
                                                          .toString(),
                                                      color:
                                                          selecteditem == index
                                                              ? Colors.white
                                                              : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // top: 3,
                                                // right: 23,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 30,
                                                  width: 30,
                                                  color: selecteditem == index
                                                      ? HexColor(
                                                          '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[index].toString())}')
                                                      : HexColor(
                                                              '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[index].toString())}')
                                                          .withOpacity(0.6),
                                                  child: Text(
                                                    info[index],
                                                    style: TextStyle(
                                                        color: selecteditem ==
                                                                index
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          // INFO AND ABILITIES TEXT
                          SizedBox(
                            height: 190,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Stack(
                                children: [
                                  Opacity(
                                    opacity: 0.5,
                                    child: Container(
                                      color: HexColor(
                                          '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[2].toString())}'),
                                    ),
                                  ),
                                  selecteditem == 4
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            agent.data[agentIndex].description,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor(
                                                  '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[0].toString())}'),
                                            ),
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  agent
                                                      .data[agentIndex]
                                                      .abilities[selecteditem]
                                                      .displayName,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  selecteditem == 4
                                                      ? 'info'
                                                      : agent
                                                          .data[agentIndex]
                                                          .abilities[
                                                              selecteditem]
                                                          .description,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: HexColor(
                                                        '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[0].toString())}'),
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
                        ],
                      ),
                    ),
                    // APP BAR
                    Positioned(
                      top: 30,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                size: 50,
                                Icons.arrow_back_ios_rounded,
                                color: HexColor(
                                    '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[3].toString())}'),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  agent.data[agentIndex].role!.displayName.name
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  agent.data[agentIndex].displayName
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: HexColor(
                                        '#${removeLastCharacter(agent.data[agentIndex].backgroundGradientColors[0].toString())}'),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                width: size.width,
                height: size.height,
                color: HexColor('e9404f'),
                child:
                    const rive.RiveAnimation.asset('assets/animation/wait.riv'),
              );
            }
          },
        ),
      ),
    );
  }

  // DELETE 2 CHARACTER FROM LAST STRING
  String removeLastCharacter(String input) {
    return input.substring(0, input.length - 2);
  }
}
