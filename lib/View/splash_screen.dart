import 'dart:async';

import 'package:covid_tracker/View/world.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void dispose() {
    super.dispose();
    animation_controller.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.push((context),
            MaterialPageRoute(builder: (context) => worldstatescreen())));
  }

  late final animation_controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: animation_controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Image(image: AssetImage('images/virus.png')),
                  ),
                ),
                // this is to rotate picture
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: animation_controller.value * 2.0 * math.pi,
                    child: child,
                  );
                }),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "covid 19 \ntracking app",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
