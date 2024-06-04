import 'dart:convert';

import 'package:dokan_demo_wedevs/Features/auth/data/store_user_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  Future<dynamic> registerUser(Map<String, dynamic> userData) async {
    print(userData);
    print('into auth repo');
    final response = await http.post(
        Uri.parse('https://apptest.dokandemo.com/wp-json/wp/v2/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print('User registered successfully: $responseBody');
      return response;
    } else {
      print('Failed to register user: ${response.statusCode}');
      return null;
    }
  }

  Future<dynamic> loginUser(Map<String, dynamic> userData) async {
    print('this is user in function - ${userData}');

    final response = await http.post(
        Uri.parse('https://apptest.dokandemo.com/wp-json/jwt-auth/v1/token'),
        headers: {"Content-Type": " application/json"},
        body: jsonEncode(userData));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print('User registered successfully: $responseBody');
      await UserData().deleteUserData();
      await UserData().storeUserData(responseBody['token'],
          responseBody['user_email'], responseBody['user_display_name']);
      await _storage.write(key: 'auth_token', value: responseBody['token']);
      return response;
    } else {
      print('Failed to register user: ${response.body}');
      return null;
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> logOut() async {
    await _storage.delete(key: 'auth_token');
  }

  
}
