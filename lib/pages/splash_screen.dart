// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  static String routeName = '/Splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat(reverse: true);
  late Animation<double> animation = CurvedAnimation(
    parent: controller,
    curve: Curves.slowMiddle,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SizeTransition(
          sizeFactor: animation,
          axis: Axis.vertical,
          child: Container(
              alignment: Alignment.center,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Splash.png'),
                  const Text(
                    'Click to continue',
                    style: TextStyle(fontSize: 35),
                  )
                ],
              ),),
        ),
      ),
    );
  }
}
