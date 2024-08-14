import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';
import 'package:valorant_api/pages/tools.dart';

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
  TextEditingController numberController = TextEditingController();
  bool vaildate = false;
  late int randomnumber;

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
  void initState() {
    randomnumber = Random().nextInt(9000) + 1000;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('0f1923'),
        title: Text(
          'Log in',
          style: TextStyle(fontSize: 32, color: HexColor('e9404f')),
        ),
        centerTitle: true,
      ),
      backgroundColor: HexColor('0f1923'),
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
                height: 450,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: HexColor('ff4655'),
                  ),
                  color: HexColor('0f1923'),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      color: HexColor('ff4655'),
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
                        CustomLogInWidget(
                          size: size,
                          keyboardType: TextInputType.emailAddress,
                          obscure: false,
                          nameController: emailController,
                          name: 'Email',
                          regex: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          error: 'Please enter a valid email address',
                          onChanged: moveEyes,
                          onTap: isCheckField,
                        ),
                        CustomLogInWidget(
                          size: size,
                          keyboardType: TextInputType.text,
                          obscure: true,
                          nameController: passwordController,
                          name: 'Password',
                          regex:
                              r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$',
                          error: 'Please enter a valid Password',
                          onChanged: moveEyes,
                          onTap: hidePassword,
                        ),
                        Container(
                          width: size.width,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: HexColor('ff4655')),
                            color: HexColor('0f1923'),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Transform.rotate(
                                angle: 0.5,
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 100,
                                      height: 60,
                                      child: Text(
                                        randomnumber.toString(),
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 23,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 30,
                                      left: 20,
                                      child: Container(
                                        width: 30,
                                        height: 2,
                                        color: Colors.red.withOpacity(0.8),
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      left: 30,
                                      child: Container(
                                        width: 30,
                                        height: 2,
                                        color: Colors.red.withOpacity(0.8),
                                      ),
                                    ),
                                    Positioned(
                                      top: 35,
                                      left: 40,
                                      child: Container(
                                        width: 30,
                                        height: 2,
                                        color: Colors.red.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 110,
                                height: 90,
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: numberController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        color: HexColor('ff4655'),
                                        fontSize: 18),
                                    label: const Text('Code'),
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                    ),
                                    border: InputBorder.none,
                                    counterStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isHadnsUp?.change(false);
                                    });
                                  },
                                  validator: (value) {
                                    if (!RegExp('[0-9]')
                                        .hasMatch(value.toString())) {
                                      return 'Enter correct number';
                                    }
                                    if (int.parse(value.toString()) !=
                                        randomnumber) {
                                      return 'Invalid code';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        InkResponse(
                          child: Container(
                            alignment: Alignment.center,
                            width: 150,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: vaildate
                                ? const SizedBox(
                                    width: 150,
                                    height: 60,
                                    child: LinearProgressIndicator())
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                    ),
                                  ),
                          ),
                          onTap: () async {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                vaildate = true;
                                isChecking?.change(false);
                                isHadnsUp?.change(false);
                                trigFail?.change(false);
                                trigSuccess?.change(true);
                              } else {
                                isChecking?.change(true);
                                isHadnsUp?.change(false);
                                trigFail?.change(true);
                                trigSuccess?.change(false);
                              }
                            });
                            await Future.delayed(const Duration(seconds: 3));
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, '/HomePage');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/HomePage');
                },
                child: const Text(
                  'Skip',
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
