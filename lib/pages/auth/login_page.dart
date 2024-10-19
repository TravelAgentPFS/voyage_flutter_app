import 'package:flutter/material.dart';

void main() {
  
}

class Login extends StatelessWidget{
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const LoginPageContent();
  }
}

class LoginPageContent extends StatefulWidget{
  const LoginPageContent({super.key});

  @override
  State<LoginPageContent> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPageContent> {
  late TextEditingController _usernameTextEditingController;
  late TextEditingController _passwordTextEditingController;

  final _formKey = GlobalKey<FormState>();

  bool hasPressedLogin = false;

  @override
  void initState() {
    super.initState();
    _usernameTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold// Font family for the input text
                    ),
                    cursorColor: const Color.fromARGB(255, 217, 111, 69),
                    controller: _usernameTextEditingController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      filled: true,

                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      labelText: 'Username',

                      labelStyle: const TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w400
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 217, 111, 69)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),

                        borderSide: const BorderSide(width: 2, color: Color.fromARGB(255, 217, 111, 69)),
                      ),

                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 217, 111, 69),
                          size: 25,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold// Font family for the input text
                    ),
                    cursorColor: const Color.fromARGB(255, 217, 111, 69),
                    controller: _passwordTextEditingController,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      filled: true,
                      labelStyle:const TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w400// Your desired font family
                        // Add other style properties as needed
                      ),

                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      labelText: 'Password',
                      floatingLabelStyle: const TextStyle(
                        fontFamily: "Raleway",
                      ),
                      // hintText: 'password',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 217, 111, 69)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),

                        borderSide: const BorderSide(width: 2, color: Color.fromARGB(255, 217, 111, 69)),
                      ),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 217, 111, 69),
                          size: 25,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password should be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 50),
                hasPressedLogin==false?ElevatedButton(
                  onPressed: () {
                    if (mounted){
                    setState(() {
                      hasPressedLogin=true;
                    });
                    }
                    if (_formKey.currentState?.validate() ?? false) {
                      print("logging in..");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 217, 111, 69),
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontFamily: "Montserrat", fontWeight: FontWeight.bold),
                  ),
                ):const Center(child: CircularProgressIndicator(strokeWidth: 2,color: Color.fromARGB(255, 217, 111, 69),)),
              ],
            ),
          ),
        ),
      ),);
  }
}

