import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:valorant_api/api/dart_api.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.size,
    required this.nameController,
    required this.name,
    required this.regex,
    required this.error,
    required this.backColor,
  });

  final Size size;
  final String name;
  final String regex;
  final String error;
  final TextEditingController nameController;
  final String backColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: HexColor(backColor).withOpacity(0.5),
        border: Border.all(
          color: HexColor(backColor),
        ),
      ),
      width: size.width,
      height: 100,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: nameController,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.black, fontSize: 18),
          label: Text(name),
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
          border: InputBorder.none,
          counterStyle: const TextStyle(color: Colors.white),
        ),
        validator: (value) {
          if (!RegExp(regex).hasMatch(value.toString())) {
            return error;
          }
          return null;
        },
      ),
    );
  }
}

class CustomLogInWidget extends StatelessWidget {
  const CustomLogInWidget({
    super.key,
    required this.size,
    required this.nameController,
    required this.name,
    required this.regex,
    required this.error,
    required this.onChanged,
    required this.onTap,
    required this.keyboardType,
    required this.obscure,
  });

  final Size size;
  final String name;
  final String regex;
  final String error;
  final TextEditingController nameController;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextInputType keyboardType;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: 80,
          child: SvgPicture.asset('assets/images/loginbox1.svg'),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          width: size.width,
          height: 110,
          child: TextFormField(
            obscureText: obscure,
            keyboardType: keyboardType,
            controller: nameController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              errorStyle: TextStyle(color: HexColor('ff4655'), fontSize: 18),
              label: Text(name),
              labelStyle: const TextStyle(
                color: Colors.white,
                fontSize: 23,
              ),
              border: InputBorder.none,
              counterStyle: const TextStyle(color: Colors.white),
            ),
            onChanged: onChanged,
            onTap: onTap,
            validator: (value) {
              if (!RegExp(regex).hasMatch(value.toString())) {
                return error;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

//information Box with agentBackgroundColor
class CustomInformationBox extends StatelessWidget {
  const CustomInformationBox({
    super.key,
    required this.lable,
    required this.category,
    required this.agentBackgroundColor,
    required this.size,
  });
  final String lable;
  final String category;
  final String agentBackgroundColor;
  final Size size;

  @override
  Widget build(BuildContext context) {
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
}

// DELETE 2 CHARACTER FROM LAST STRING
String removeLastCharacter(String input) {
  return input.substring(0, input.length - 2);
}

// Search method for find and show agent with name
class SearchAgents extends StatelessWidget {
  const SearchAgents({
    super.key,
    required this.searchString,
    required this.size,
  });

  final TextEditingController searchString;
  final Size size;

  @override
  Widget build(BuildContext context) {
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

// Search Method for find and show maps with names
class SearchMaps extends StatelessWidget {
  const SearchMaps({
    super.key,
    required this.searchString,
    required this.size,
  });

  final TextEditingController searchString;
  final Size size;

  @override
  Widget build(BuildContext context) {
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
}

// A custom widget from InkResposne get pagename, assets, name,
class CustomInkResposne extends StatelessWidget {
  const CustomInkResposne({
    super.key,
    required this.size,
    required this.pagename,
    required this.assetDir,
    required this.name,
    required this.imageHeight,
  });

  final Size size;
  final Widget pagename;
  final String assetDir;
  final String name;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OpenContainer(
        closedColor: HexColor('141e29'),
        closedElevation: 0.0,
        middleColor: HexColor('141e29'),
        transitionDuration: const Duration(milliseconds: 350),
        transitionType: ContainerTransitionType.fadeThrough,
        closedBuilder: (context, action) {
          return InkResponse(
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
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: HexColor('ff4655'),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        SvgPicture.asset(
                          width: 170,
                          height: 170,
                          'assets/images/agentBack.svg',
                        ),
                        Positioned(
                          right: 0,
                          bottom: 20,
                          child: Image.asset(
                            filterQuality: FilterQuality.high,
                            height: imageHeight,
                            fit: BoxFit.fitHeight,
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
