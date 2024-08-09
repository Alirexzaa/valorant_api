import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';

class LogInPage extends StatefulWidget {
  static String routeName = '/logInPage';

  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  StateMachineController? stateMachineController;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHadnsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  SMINumber? numLook;

  void isCheckField() {
    isHadnsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void moveEyes(value) {
    numLook?.change(value.length.toDouble());
  }

  void hidePassword() {
    isHadnsUp?.change(true);
  }

  artboardDef(artboard) {
    stateMachineController =
        StateMachineController.fromArtboard(artboard, 'Login Machine');
    if (stateMachineController == null) return;
    artboard.addController(stateMachineController!);
    isChecking = stateMachineController?.findInput('isChecking');
    isHadnsUp = stateMachineController?.findInput('isHandsUp');
    trigSuccess = stateMachineController?.findInput('trigSuccess');
    trigFail = stateMachineController?.findInput('trigFail');
    numLook = stateMachineController?.findSMI('numLook');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('e9404f'),
        title: const Text(
          'Log in',
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
      ),
      backgroundColor: HexColor('e9404f'),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 300,
                child: RiveAnimation.asset(
                  'assets/animation/animated_login_character.riv',
                  stateMachines: const ['Login Machine'],
                  onInit: artboardDef,
                ),
              ),
              Container(
                width: size.width - 70,
                height: 350,
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
                                onChanged: moveEyes,
                                onTap: isCheckField,
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
                                onChanged: moveEyes,
                                onTap: hidePassword,
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
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                isChecking?.change(false);
                                isHadnsUp?.change(false);
                                trigFail?.change(false);
                                trigSuccess?.change(true);
                              } else {
                                isChecking?.change(false);
                                isHadnsUp?.change(false);
                                trigFail?.change(true);
                                trigSuccess?.change(false);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/SignupPage');
                },
                child: const Text(
                  'You havent created an account yet?',
                  style: TextStyle(
                    color: Colors.white,
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
