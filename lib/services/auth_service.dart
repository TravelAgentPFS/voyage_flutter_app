import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:voyage_flutter_app/config/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:developer';

class AuthService{
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Future<http.Response?> register(String email, String name, String password) async {
    try {
      var regBody = {
        'email': email,
        'name': name,
        'password': password
      };

      var response = await http.post(
        Uri.parse(registerUrl), // Replace with your actual URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      return response;
    } catch (e) {
      log('Error: $e');
      rethrow;
       // Re-throwing the error to be handled in the calling function
    }
    // return null;
  }

  Future<http.Response?> login(String email, String password) async {
    log("ACCESSING LOGIN");
    try {
      var regBody = {
        "username": email,
        "password": password,
      };

      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        String token = response.headers["authorization"].toString().split(' ')[1];
        // log(responseBody);
        log(token);
        await storage.write(key: 'auth_token', value: token);
        await storage.write(key: 'image', value: responseBody['image']);
        await storage.write(key: 'name', value: responseBody['name']);
        // await storage.write(
        //     key: 'user_isMarchand', value: user['isMarchand'].toString());
        // await storage.write(
        //     key: 'user_telephone', value: user['telephone'].toString());
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('user_nom', user['nom']);
        // await prefs.setString('user_prenom', user['prenom']);
        // await prefs.setString('user_telephone', user['telephone'].toString());
        // await prefs.setString('user_password', user['password']);
        // // await prefs.setString('user_marchandData', user['marchandData']);
        // await prefs.setString('user_id', user['_id']);

        // PaymentChecker().startChecking();
        return response;
      } else if (response.statusCode == 400) {
        var responseBody = jsonDecode(response.body);
        log('Error ${responseBody["statusCode"]} : ${responseBody['message']}');
        return response;
      } else {
        log('Unexpected status code: ${response.statusCode}');
        return response;
      }
    } catch (e) {
      log('Error: $e');
    }
    return null;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_nom');
    await prefs.remove('user_prenom');
    await prefs.remove('user_telephone');
    await prefs.remove('user_password');
    await prefs.remove('user_rib');

    // await storage.delete(key: 'user_isMarchant');
    // await storage.delete(key: 'auth_token');
    // await storage.delete(key: 'card');
    log('logged out!');
    // Navigator.pushReplacementNamed(context, '/login');
  }

  // Future<String?> getToken() async {
  //   return await storage.read(key: 'auth_token');
  // }
}