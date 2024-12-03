import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Profile ',
                  style: TextStyle(fontSize: 22.0, fontFamily: ''),
                ),
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      const NetworkImage('https://via.placeholder.com/150'),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'ANWAR ANWAR',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                _buildEditableField(
                  label: 'Email',
                  value: 'emtiaj0077@gmail.com',
                  icon: Icons.email,
                ),
                _buildEditableField(
                  label: 'Phone',
                  value: '+8801708349891',
                  icon: Icons.phone,
                ),
                _buildEditableField(
                  label: 'Date of Birth',
                  value: '27-11-2000',
                  icon: Icons.calendar_today,
                ),
                _buildEditableField(
                  label: 'Gender',
                  value: 'Male',
                  icon: Icons.person,
                ),
                _buildEditableField(
                  label: 'Address',
                  value: 'New Adorsho Para, Rangpur - 5400',
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: screenWidth * 0.8,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add your edit profile functionality here
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Details'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: value,
        readOnly: false,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: IconButton(
            icon: Icon(icon),
            onPressed: () {
              // Add edit functionality here
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // filled: true,
          // fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}
