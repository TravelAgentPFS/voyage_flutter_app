// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:path/path.dart';
import 'package:voyage_flutter_app/config/url.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:developer';

class QueryService {
  Future<dynamic> postQuery(String query, BuildContext context) async {
    try {
      var regBody = {
        'query': query,
      };
      // throw Exception("TEST ERROR");
      var response = await http.post(
        Uri.parse(aiQueryUrl), // Replace with your actual URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );
      log('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        // log('Response body: ${response.body}');
        return jsonDecode(response.body);
      } else {
        return {"flights": [], "hotels": [], "activities": []};
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
      log('Error: $e');
      return {"flights": [], "hotels": [], "activities": []};
    }
    // return null;
  }

  Future<dynamic> getQueries() async {
    try {
      var response = await http.get(
        headers: {
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkB0ZXN0LmNvbSIsImlhdCI6MTczNDM4NTgyMSwiZXhwIjoxNzM0Mzg3NjIxfQ.ANMda9hiUO_JseR_oQERJSZvMXz2SqQEHI7gAFq8QRM"
        },
        Uri.parse(queryUrl),
      );

      print("response.statusCode : ");
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse is List) {
          return jsonResponse;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load queries: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching queries: $e');
    }
  }
}
