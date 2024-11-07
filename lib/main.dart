import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voyage_flutter_app/pages/Home.dart';
import 'package:voyage_flutter_app/pages/auth/login_page.dart';
import 'package:voyage_flutter_app/pages/auth/register_page.dart';
import 'package:voyage_flutter_app/pages/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); // stop horizontal view
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // hide debug banner
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: "/",
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/': (context) => const Splash(), //hadi katbda lwla par defauts
        '/home': (context) =>
            const MyHomePage(title: "Hello"), //hadi katbda lwla par defauts
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
      },
    );
  }
}
