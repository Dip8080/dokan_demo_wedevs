import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRepository {
  Future<void> registerUser(Map<String, dynamic> userData) async {
    print(userData);
    print('into auth repo');
    final response = await http.post(
        Uri.parse('https://apptest.dokandemo.com/wp-json/wp/v2/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print('User registered successfully: $responseBody');
    } else {
      print('Failed to register user: ${response.statusCode}');
    }
  }

  Future<void> loginUser(Map<String, dynamic> userData) async {
    print('this is user in function - ${userData}');

    final response = await http.post(
        Uri.parse('https://apptest.dokandemo.com/wp-json/jwt-auth/v1/token'),
        headers: {"Content-Type": " application/x-www-form-urlencoded"},
        body: jsonEncode(userData));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print('User registered successfully: $responseBody');
    } else {
      print('Failed to register user: ${response.body}');
    }
  }
}
