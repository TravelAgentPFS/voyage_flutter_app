// ignore: file_names
import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late FocusNode emailFocusNode;
  late FocusNode phoneFocusNode;
  late FocusNode dateFocusNode;
  late FocusNode genderFocusNode;
  late FocusNode addressFocusNode;

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    dateFocusNode = FocusNode();
    genderFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    // Add listeners to update state on focus change
    emailFocusNode.addListener(() {
      setState(() {}); // Rebuild to update label color when focus changes
    });
    phoneFocusNode.addListener(() {
      setState(() {});
    });
    dateFocusNode.addListener(() {
      setState(() {});
    });
    genderFocusNode.addListener(() {
      setState(() {});
    });
    addressFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Clean up the focus nodes when the widget is disposed
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    dateFocusNode.dispose();
    genderFocusNode.dispose();
    addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(205, 116, 162, 165),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.account_circle,
                      color: Color.fromARGB(205, 116, 162, 165),
                      size: 90,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'ANWAR ANWAR',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(205, 116, 162, 165),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    _buildEditableField(
                      label: 'Email',
                      value: 'emtiaj0077@gmail.com',
                      icon: Icons.email,
                      myFocusNode: emailFocusNode,
                    ),
                    _buildEditableField(
                      label: 'Phone',
                      value: '+8801708349891',
                      icon: Icons.phone,
                      myFocusNode: phoneFocusNode,
                    ),
                    _buildEditableField(
                      label: 'Date of Birth',
                      value: '27-11-2000',
                      icon: Icons.calendar_today,
                      myFocusNode: dateFocusNode,
                    ),
                    _buildEditableField(
                      label: 'Gender',
                      value: 'Male',
                      icon: Icons.person,
                      myFocusNode: genderFocusNode,
                    ),
                    _buildEditableField(
                      label: 'Address',
                      value: 'New Adorsho Para, Rangpur - 5400',
                      icon: Icons.location_on,
                      myFocusNode: addressFocusNode,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: SizedBox(
                width: screenWidth * 0.75,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add your edit profile functionality here
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Edit Details',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(205, 116, 162, 165),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3, // Add some shadow for elevation
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required String value,
    required IconData icon,
    required FocusNode myFocusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        focusNode: myFocusNode,
        initialValue: value,
        readOnly: false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15.0),
          labelText: label,
          labelStyle: TextStyle(
              color: myFocusNode.hasFocus
                  ? const Color.fromARGB(205, 116, 162, 165)
                  : Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(
              icon,
              color: const Color.fromARGB(205, 116, 162, 165),
            ),
            onPressed: () {
              // Add edit functionality here
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 212, 212, 212), // Border color
              width: 2.0, // Border width
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color.fromARGB(205, 116, 162, 165), // Border color
              width: 2.0, // Border width
            ),
          ),
        ),
      ),
    );
  }
}
