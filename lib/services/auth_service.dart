import 'package:http/http.dart' as http;
import 'package:voyage_flutter_app/config/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:developer';

class AuthService{
  Future<http.Response> register(String email, String name, String password) async {
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
      rethrow; // Re-throwing the error to be handled in the calling function
    }
  }

  Future<http.Response?> login(String email, String password) async {
    print("ACCESSING LOGIN");
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
        // String token = respoody['data']['client'];
        print(responseBody);
        // await storage.write(key: 'auth_token', value: token);
        // // print(user['marchandData']);
        // await storage.write(
        //     key: 'user_marchandData', value: jsonEncode(user['marchandData']));
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
        print('Error ${responseBody["statusCode"]} : ${responseBody['message']}');
        return response;
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return response;
      }
    } catch (e) {
      print('Error: $e');
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