// import 'dart:ui';

import 'package:flutter/material.dart';

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
            if (snapshot.hasData) {
              var agent = snapshot.data!.data;
              var backgroundColors = agent[agentIndex].backgroundGradientColors;
              return Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // radius: 1.5,
                    colors: [
                      HexColor(
                          '#${removeLastCharacter(backgroundColors[3].toString())}'),
                      HexColor(
                          '#${removeLastCharacter(backgroundColors[2].toString())}'),
                      HexColor(
                          '#${removeLastCharacter(backgroundColors[1].toString())}'),
                      HexColor(
                          '#${removeLastCharacter(backgroundColors[0].toString())}'),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // AGENT PIC
                    Positioned(
                      top: -100,
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width,
                        height: size.height,
                        child: Stack(
                          children: [
                            Image.network(
                                color: Colors.white.withOpacity(0.7),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                agent[agentIndex].background.toString()),
                            // Positioned(
                            //   left: 0,
                            //   top: 0,
                            //   right: -20,
                            //   bottom: -20,
                            //   child: Image.network(
                            //       color: Colors.grey[900]!.withOpacity(0.5),
                            //       filterQuality: FilterQuality.high,
                            //       scale: 2,
                            //       fit: BoxFit.cover,
                            //       alignment: Alignment.center,
                            //       agent.data[agentIndex].fullPortrait
                            //           .toString()),
                            // ),
                            Image.network(
                                height: 650,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                agent[agentIndex].fullPortrait.toString()),
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
                              SizedBox(
                                width: size.width - 80,
                                height: 90,
                                child: AnimatedGrid(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                  ),
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
                                        child: AnimatedContainer(
                                          duration: const Duration(seconds: 1),
                                          width: 60,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: selecteditem == index
                                                  ? HexColor(
                                                      '#${removeLastCharacter(backgroundColors[index].toString())}')
                                                  : HexColor(
                                                          '#${removeLastCharacter(backgroundColors[index].toString())}')
                                                      .withOpacity(0.6),
                                              border: Border.all(
                                                width: 4,
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16.0)),
                                          child: AnimatedPadding(
                                            duration: Duration(seconds: 1),
                                            padding: const EdgeInsets.all(3.0),
                                            child: Image.network(
                                              agent[agentIndex]
                                                  .abilities[index]
                                                  .displayIcon
                                                  .toString(),
                                              color: selecteditem == index
                                                  ? Colors.white
                                                  : Colors.black,
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
                                          '#${removeLastCharacter(backgroundColors[2].toString())}'),
                                    ),
                                  ),
                                  selecteditem == 4
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            agent[agentIndex].description,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor(
                                                  '#${removeLastCharacter(backgroundColors[0].toString())}'),
                                            ),
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  agent[agentIndex]
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
                                                      : agent[agentIndex]
                                                          .abilities[
                                                              selecteditem]
                                                          .description,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: HexColor(
                                                        '#${removeLastCharacter(backgroundColors[0].toString())}'),
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
                                    '#${removeLastCharacter(backgroundColors[3].toString())}'),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  agent[agentIndex]
                                      .role!
                                      .displayName
                                      .name
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  agent[agentIndex].displayName.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: HexColor(
                                        '#${removeLastCharacter(backgroundColors[0].toString())}'),
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
