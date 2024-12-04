// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:voyage_flutter_app/widgets/activities_tab_bar.dart';
import 'package:voyage_flutter_app/services/query_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  QueryService queryService = QueryService();
  String? base64ProfileImg;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  bool resultsReady = false;
  bool hasEnteredQuery = false;
  String username = "";
  bool isTextFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    _controller.addListener(() {
      setState(() {
        isTextFieldEmpty = _controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
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
                )),
            const SizedBox(height: 10 //size.height * 0.05,
                ),
            resultsReady
                ? const SizedBox.shrink()
                : Positioned(
                    top: size.height * 0.2,
                    left: 0,
                    right: 0,
                    child: hasEnteredQuery
                        ? const Center(
                            child: CircularProgressIndicator(
                                backgroundColor:
                                    Color.fromARGB(255, 100, 100, 100),
                                strokeWidth: 9,
                                color: Color.fromARGB(255, 0, 0, 0)))
                        : const Text(
                            "Where would you like to go?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77),
                              fontSize: 25,
                              fontFamily: "monospace",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
            AnimatedPositioned(
              // height: 200,
              // top: !resultsReady? size.height*0.7-150:20+(size.width * 0.2),
              top: !resultsReady ? size.height * 0.5 : 10 + (size.width * 0.2),
              left: 0,
              right: 0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      sendQuery(value);
                    }
                  },
                  cursorColor: Colors.black,
                  minLines: 1,
                  maxLines: resultsReady ? 1 : 5,
                  maxLength: 600,
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
                    prefixIcon: isTextFieldEmpty
                        ? const Icon(Icons.search)
                        : IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () {
                              _controller.clear();
                            },
                          ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(30.0), // Rounded corners
                    ),
                    labelText: 'Enter your query ...',
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize
                          .min, // Prevents the row from taking up all available space
                      children: [
                        IconButton(
                          icon: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 238, 144, 0),
                            ),
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              sendQuery(_controller.text);
                            }
                          },
                        ),
                        IconButton(
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
                          onPressed: () {
                            // Clear action
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: 80 + (size.width * 0.2) + (!resultsReady ? size.height : 0),
              left: 0,
              right: 0,
              child: const ActivitiesTabBar(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 238, 144, 3),
        onPressed: () => {
          hasEnteredQuery = !hasEnteredQuery,
          Future.delayed(const Duration(seconds: 5), () {
            setState(() {
              resultsReady = !resultsReady;
            });
          })
        },
        tooltip: 'Increment',
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  void sendQuery(String text) async {
    log("Pressed Submit: $text");
    setState(() {
      hasEnteredQuery = true;
      resultsReady = false;
    });

    // dynamic results = await queryService.postQuery(text,context);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        resultsReady = true;
      });
    });
  }
}
