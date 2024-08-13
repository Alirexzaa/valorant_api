import 'package:flutter/material.dart';
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
  String agentColor = '0f1923';

  Future<void> _writeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
    await prefs.setString('color', agentColor);
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
      backgroundColor: HexColor('e9404f'),
      appBar: AppBar(
        backgroundColor: HexColor('e9404f'),
        title: const Text(
          'Sign up',
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                            agentColor = (removeLastCharacter(agentData[value]
                                    .backgroundGradientColors[0]))
                                .toString();
                            print(value);
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
              Container(
                alignment: Alignment.center,
                width: size.width,
                height: 20,
                child: SmoothPageIndicator(
                  controller: pageController, // PageController
                  count: 30,
                  effect: const ScrollingDotsEffect(
                    maxVisibleDots: 11,
                    activeDotColor: Colors.black,
                  ), // your preferred effect
                ),
              ),
              Container(
                width: size.width - 70,
                height: 500,
                decoration: BoxDecoration(
                  color: HexColor('ff4649'),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 10),
                      color: Colors.black,
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
                        Stack(
                          children: [
                            SizedBox(
                              width: size.width,
                              height: 80,
                              child: SvgPicture.asset(
                                  'assets/images/loginbox.svg'),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              width: size.width,
                              height: 110,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: nameController,
                                cursorColor: Colors.white,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  label: Text('name'),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                  ),
                                  border: InputBorder.none,
                                  counterStyle: TextStyle(color: Colors.white),
                                ),
                                validator: (value) {
                                  if (nameController.text.length < 2) {
                                    return 'bigger than 5 characters,please';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              width: size.width,
                              height: 80,
                              child: SvgPicture.asset(
                                  'assets/images/loginbox.svg'),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              width: size.width,
                              height: 110,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                cursorColor: Colors.white,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  label: Text('Email'),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                  ),
                                  border: InputBorder.none,
                                  counterStyle: TextStyle(color: Colors.white),
                                ),
                                validator: (value) {
                                  if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value.toString())) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              width: size.width,
                              height: 80,
                              child: SvgPicture.asset(
                                  'assets/images/loginbox.svg'),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              width: size.width,
                              height: 110,
                              child: TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.name,
                                controller: passwordController,
                                cursorColor: Colors.white,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  label: Text('Password'),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                  ),
                                  border: InputBorder.none,
                                  counterStyle: TextStyle(color: Colors.white),
                                ),
                                validator: (value) {
                                  if (!RegExp(
                                          r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$')
                                      .hasMatch(value.toString())) {
                                    return 'Please enter a valid Password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        InkResponse(
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
