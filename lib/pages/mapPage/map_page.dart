import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:valorant_api/api/dart_api.dart';
import 'package:hexcolor/hexcolor.dart';

class MapPage extends StatefulWidget {
  static String routeName = '/MapPage';

  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool floatingActionButtonSelected = false;
  TextEditingController searchString = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: HexColor('0f1923'),
      appBar: AppBar(
        backgroundColor: HexColor('0f1923'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Maps',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            size: 40,
          ),
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            FutureBuilder(
              future: fetchMaps(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var mapData = snapshot.data;
                  return ListView.builder(
                    itemCount: mapData!.data.length,
                    itemBuilder: (context, index) {
                      if (mapData.data[index].displayName
                              .toLowerCase()
                              .contains(searchString.text.toLowerCase()) &&
                          mapData.data[index].displayIcon != null) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkResponse(
                            onTap: () {
                              Navigator.pushNamed(context, '/MapsDetailPage',
                                  arguments: index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: HexColor('ff4655'),
                                ),
                              ),
                              width: size.width,
                              height: 290,
                              child: Stack(
                                children: [
                                  Positioned(
                                    width: size.width,
                                    height: 290,
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                      mapData.data[index].splash,
                                    ),
                                  ),
                                  SizedBox(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5.0, sigmaY: 5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.0)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 30,
                                    top: 50,
                                    bottom: 50,
                                    child: Image.network(
                                      filterQuality: FilterQuality.high,
                                      mapData.data[index].displayIcon
                                          .toString(),
                                    ),
                                  ),
                                  Positioned(
                                    right: 40,
                                    top: 30,
                                    child: Column(
                                      children: [
                                        Text(
                                          mapData.data[index].displayName,
                                          style: TextStyle(
                                            color: HexColor('ff4655'),
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                }
                return const Center(
                  child: RiveAnimation.asset('assets/animation/wait.riv'),
                );
              },
            ),
            floatingActionButtonSelected
                ? Positioned(
                    bottom: 12,
                    left: 35,
                    child: SizedBox(
                      width: 300,
                      height: 60,
                      child: Stack(
                        children: [
                          SizedBox(
                              height: 60,
                              width: 300,
                              child: SvgPicture.asset(
                                  'assets/images/whiteSeachBox.svg')),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autofocus: true,
                              controller: searchString,
                              cursorColor: HexColor('e9404f'),
                              style: const TextStyle(fontSize: 23),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  searchString.text = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(),
        backgroundColor:
            floatingActionButtonSelected ? HexColor('D9D9D9') : Colors.black,
        splashColor:
            floatingActionButtonSelected ? Colors.black : HexColor('e9404f'),
        onPressed: () {
          setState(() {
            floatingActionButtonSelected = !floatingActionButtonSelected;
          });
        },
        child: floatingActionButtonSelected
            ? const Icon(Icons.check)
            : Icon(
                Icons.search,
                color: HexColor('e9404f'),
              ),
      ),
    );
  }
}
