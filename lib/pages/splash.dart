import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:voyage_flutter_app/pages/Home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashIconSize: 350,
        splash: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.contain, // or BoxFit.cover
          // Path to your SVG file
        ),
        backgroundColor: Colors.white,
        duration: 1000,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: MyHomePage(
          title: "HELLO",
        ),
      ),
    );
  }
}
