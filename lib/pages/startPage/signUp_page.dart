import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:valorant_api/api/dart_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  static String routeName = '/SignupPage';

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PageController pageController = PageController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int imageIndex = 0;
  String agentColor = 'c7f458';

  Future<void> _writeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
    await prefs.setInt('imageIndex', imageIndex);
  }

  // DELETE 2 CHARACTER FROM LAST STRING
  String removeLastCharacter(String input) {
    return input.substring(0, input.length - 2);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: HexColor('0f1923'),
      // AppBar
      appBar: AppBar(
        backgroundColor: HexColor('0f1923'),
        title: Text(
          'Sign up',
          style: TextStyle(
            fontSize: 32,
            color: HexColor('ff4649'),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            color: HexColor('ff4649'),
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      // Body
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Agent Avatar
              SizedBox(
                width: size.width,
                height: 250,
                child: FutureBuilder(
                  future: fetchAgents(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var agentData = snapshot.data!.data;

                      return PageView.builder(
                        onPageChanged: (value) {
                          setState(() {
                            imageIndex = value;
                            agentColor = (removeLastCharacter(
                                agentData[value].backgroundGradientColors[0]));
                            print(agentColor);
                          });
                        },
                        controller: pageController,
                        itemCount: agentData.length,
                        itemBuilder: (context, index) {
                          return CircleAvatar(
                            maxRadius: 30.0,
                            backgroundColor: HexColor(
                                    '#${removeLastCharacter(agentData[index].backgroundGradientColors[0].toString())}')
                                .withOpacity(0.5),
                            child: agentData[index].isPlayableCharacter
                                ? Image.network(
                                    height: 150,
                                    agentData[index].displayIcon.toString())
                                : const SizedBox(
                                    child: RiveAnimation.asset(
                                        'assets/animation/wait.riv'),
                                  ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: RiveAnimation.asset('assets/animation/wait.riv'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              // PageIndicator
              Container(
                alignment: Alignment.center,
                width: size.width,
                height: 20,
                child: SmoothPageIndicator(
                  onDotClicked: (index) {
                    setState(() {
                      pageController.jumpToPage(index);
                    });
                  },
                  controller: pageController, // PageController
                  count: 30,
                  effect: ScrollingDotsEffect(
                    maxVisibleDots: 11,
                    activeDotColor: HexColor('ff4655'),
                  ), // your preferred effect
                ),
              ),
              const SizedBox(height: 10),
              // Sign Up Box
              Container(
                width: size.width - 70,
                height: 500,
                decoration: BoxDecoration(
                  color: HexColor('0f1923'),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      color: HexColor(agentColor),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextFormField(
                          size: size,
                          nameController: nameController,
                          name: 'name',
                          regex: r'([a-zA-Z0-9_\s]+)',
                          error: 'please enter a vaild name',
                          backColor: agentColor,
                        ),
                        CustomTextFormField(
                          size: size,
                          nameController: emailController,
                          name: 'Email',
                          regex: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          error: 'Please enter a valid email address',
                          backColor: agentColor,
                        ),
                        CustomTextFormField(
                          size: size,
                          nameController: passwordController,
                          name: 'Password',
                          regex:
                              r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$',
                          error: 'Please enter a valid Password',
                          backColor: agentColor,
                        ),
                        InkResponse(
                          splashColor: HexColor(agentColor),
                          child: Container(
                            alignment: Alignment.center,
                            width: 150,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _writeData();
                                Navigator.pushNamed(context, '/HomePage');
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
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
  String backColor;

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
