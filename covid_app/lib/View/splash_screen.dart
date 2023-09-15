import 'dart:async';

import 'package:covid_app/View/worldstates.dart';
import 'package:flutter/material.dart';
import 'dart:math'as math;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

late final AnimationController controller = AnimationController(
  duration: const Duration(seconds: 2),
  vsync: this)..repeat();
  @override
  void dispose()
  {
    super.dispose();
    controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () => Navigator.push(context,MaterialPageRoute(builder: (context) => const WorldStatesScreen())));
   
    

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
                AnimatedBuilder(animation: controller,
                child: const SizedBox(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Image(image: AssetImage('images/virus.png'),),
                  ),
                ),
                 builder:(BuildContext context,Widget?child){
                  return Transform.rotate(
                    angle: controller.value * 2.0 * math.pi,
                    child: child);
                 }),
                 SizedBox(height: 20,),
                 Align(alignment:Alignment.center ,child :const Text('Covid 19 \nTraker App',textAlign: TextAlign.center ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),))
          ],
        ),
      ), 
    );
  }
}
