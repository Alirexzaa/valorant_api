import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:valorant_api/api/dart_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant_api/pages/constants.dart';
import 'package:valorant_api/pages/tools.dart';

class SignUpPage extends StatefulWidget {
  static String routeName = '/SignupPage';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
      backgroundColor: Constants.primaryColor,
      // AppBar
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Text(
          'Sign up',
          style: TextStyle(
            fontSize: 32,
            color: Constants.secondPrimaryColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            color: Constants.secondPrimaryColor,
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
                            debugPrint(agentColor);
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
                                : SizedBox(
                                    child: RiveAnimation.asset(
                                        Constants.loadingRiveAnimation),
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
                    activeDotColor: Constants.secondPrimaryColor,
                  ), // your preferred effect
                ),
              ),
              const SizedBox(height: 10),
              // Sign Up Box
              Container(
                width: size.width - 70,
                height: 500,
                decoration: BoxDecoration(
                  color: Constants.primaryColor,
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
                          regex: Constants.nameReGex,
                          error: 'please enter a vaild name',
                          backColor: agentColor,
                        ),
                        CustomTextFormField(
                          size: size,
                          nameController: emailController,
                          name: 'Email',
                          regex: Constants.emailReGex,
                          error: 'Please enter a valid email address',
                          backColor: agentColor,
                        ),
                        CustomTextFormField(
                          size: size,
                          nameController: passwordController,
                          name: 'Password',
                          regex: Constants.passWordReGex,
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
