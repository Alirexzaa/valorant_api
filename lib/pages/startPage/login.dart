import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: HexColor('d6e2ea'),
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
                  onInit: (artboard) {
                    stateMachineController =
                        StateMachineController.fromArtboard(
                            artboard, 'Login Machine');
                    if (stateMachineController == null) return;
                    artboard.addController(stateMachineController!);
                    isChecking =
                        stateMachineController?.findInput('isChecking');
                    isHadnsUp = stateMachineController?.findInput('isHandsUp');
                    trigSuccess =
                        stateMachineController?.findInput('trigSuccess');
                    trigFail = stateMachineController?.findInput('trigFail');
                    numLook = stateMachineController?.findSMI('numLook');
                  },
                ),
              ),
              SizedBox(
                width: size.width,
                height: 500,
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: moveEyes,
                            onTap: isCheckField,
                            validator: (value) {
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value.toString())) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onTap: hidePassword,
                          ),
                        ),
                      ],
                    )),
              ),
              ElevatedButton(
                onPressed: () {
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
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
