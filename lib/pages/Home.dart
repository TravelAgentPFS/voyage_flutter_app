// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:voyage_flutter_app/widgets/activities_tab_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String? base64ProfileImg;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String username="";
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load the profile image from secure storage
  Future<void> _loadData() async {
    String? storedBase64Img = await storage.read(key: 'image');
    if (storedBase64Img != null && _isValidBase64Image(storedBase64Img)) {
      setState(() {
        base64ProfileImg = storedBase64Img;
      });
    }
    String? storedUsername = await storage.read(key: "name");
    setState(() {
      username = storedUsername ?? "";
    });
  }

  // Validate the base64 string for an image
  bool _isValidBase64Image(String base64Str) {
    try {
      final decodedBytes = base64.decode(base64Str);
      // Check if the size is reasonable (e.g., less than 5MB)
      if (decodedBytes.length > 1024 * 1024 * 5) {
        return false; // Image is too large
      }
      // Optionally check if it decodes into a valid image format
      return true;
    } catch (e) {
      return false; // Invalid base64 string
    }
  }

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
                  Flexible(
                    // fit: FlexFit.tight,
                    child: FittedBox(
                      // fit: BoxFit.scaleDown,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, $username",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 22,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
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
                  base64ProfileImg != null
                      ? ClipOval(
                          child: Image.memory(
                            base64Decode(base64ProfileImg!),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.account_circle,
                          color: Color.fromARGB(205, 116, 162, 165),
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
                          color: Color.fromARGB(255, 0,0,0),
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
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}
