import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LogInPage extends StatefulWidget {
  static String routeName = '/logInPage';

  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late RiveAnimationController _idleController;
  late RiveAnimationController _successController;

  @override
  void initState() {
    super.initState();
    _idleController = SimpleAnimation('idle');
    _successController = SimpleAnimation('success');
  }

  void _onLoginPressed() {
    // Replace this with your actual login logic
    // For demonstration purposes, we'll just toggle the animation
    setState(() {
      _idleController.isActive = false;
      _successController.isActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: 300,
              child: RiveAnimation.asset(
                controllers: [_idleController, _successController],
                'assets/animation/animated_login_character.riv',
              ),
            ),
            ElevatedButton(
              onPressed: _onLoginPressed,
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _idleController.isActive = true;
                  _successController.isActive = false;
                });
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
