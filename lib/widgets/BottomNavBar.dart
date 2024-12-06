import 'package:flutter/material.dart';
import 'package:voyage_flutter_app/pages/Home.dart';
import 'package:voyage_flutter_app/pages/Profile.dart'; // Import your pages

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0; // Keeps track of the selected tab index

  static final List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    const Center(child: Text('History Page')),
    Profile(),
    const Center(child: Text('Settings Page')), // Add a unique fourth page
  ];

  // Method to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        // Styling options
        selectedItemColor:
            const Color.fromARGB(255, 253, 128, 2), // Selected item color
        unselectedItemColor: Colors.grey, // Unselected item color
        selectedFontSize: 14, // Font size for selected item
        unselectedFontSize: 12, // Font size for unselected items
        backgroundColor: Colors.white, // Background color of nav bar
        type: BottomNavigationBarType.fixed, // Prevents shifting when tapping
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto', // Custom font family
          color: Color.fromARGB(255, 253, 128, 2),
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Roboto', // Custom font family
          color: Colors.grey,
        ),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
