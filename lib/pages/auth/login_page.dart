import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:voyage_flutter_app/services/auth_service.dart';

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
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;

  final _formKey = GlobalKey<FormState>();

  AuthService authService = AuthService();
  bool hasPressedLogin = false;

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
  }
  
void loginUser() async {
    String email= _emailTextEditingController.text;
    String password= _passwordTextEditingController.text;
    
    try{
      final response = await authService.login(email,password);
      if (response != null) {
        if (response.statusCode == 200 && mounted) {
          Navigator.pushReplacementNamed(context, '/home');
          // var responseBody = jsonDecode(response.body);
          // log(responseBody.toString());
        } else if (response.statusCode == 400) {
          var responseBody = jsonDecode(response.body);
          
          log(responseBody.toString());
          // String errorMessage = responseBody['message'];
          // print('Error message: $errorMessage');

          // if(mounted){
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text(errorMessage)),
          //   );}
        } else {
          // Handle unexpected status codes
          if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected status code: ${response.statusCode}')),
          );}
        }
      } else {
        // Handle null response
        if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No response received. Please check your internet connection.')),
        );}
      }
      if (mounted){
        setState(() {
          hasPressedLogin=false;
        });}
    } catch (e) {
      log('Error in loginUser: $e');
      if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
      );}
    }
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
                    controller: _emailTextEditingController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      filled: true,

                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      labelText: 'Email',

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
                        return 'Please enter your email';
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
                      if (value.length < 5) {
                        return 'Password should be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 50),
                hasPressedLogin==false?ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (mounted){
                        setState(() {
                          hasPressedLogin=true;
                        });
                      }
                      loginUser();
                      log("logging in..");
                    } else {
                      if (mounted){
                        setState(() {
                          hasPressedLogin=false;
                        });
                      }
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
                hasPressedLogin==false?TextButton(onPressed: ()=>Navigator.pushNamed(context,"/register"),
                 child:const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Don't have an account? Create one!",style:TextStyle(color:Color.fromARGB(255, 217, 111, 69)))],
                  )):const SizedBox.shrink(),
              
              ///DEBUGGING
              ///
              TextButton(onPressed: ()=>Navigator.pushNamed(context,"/home"),child: const Text("[DEBUG]: go to /home"),)
              ///
              ///DEBUGGING
              
              ],
            ),
          ),
        ),
      ),);
  }
}

