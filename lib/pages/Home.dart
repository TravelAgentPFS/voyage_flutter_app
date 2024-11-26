import 'package:flutter/material.dart';
import 'package:voyage_flutter_app/widgets/activities_tab_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: size.width * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Flexible(
                    // fit: FlexFit.tight,
                    child: FittedBox(
                      // fit: BoxFit.scaleDown,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, mamoma",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 22,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Welcome to travel agent",
                            style: TextStyle(
                              color: Color.fromARGB(255, 137, 137, 137),
                              fontSize: 18,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  const Icon(
                    Icons.account_circle,
                    color: Color.fromARGB(205, 116, 162, 165),//Color.fromARGB(255, 217, 217, 217),
                    size: 40,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10//size.height * 0.05,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 230, 230, 230),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(30.0), // Rounded corners
                    ),
                    labelText: 'Search for a destination ...',
                    suffixIcon: IconButton(
                      icon: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: const Icon(
                          Icons.tune_rounded,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    )),
              ),
            ),
            const ActivitiesTabBar(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 238, 144, 3),
        onPressed: () => Navigator.pushNamed(context, "/login"),
        tooltip: 'Increment',
        child: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }
}
