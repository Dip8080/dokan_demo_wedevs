import 'dart:convert';

import 'package:dokan_demo_wedevs/Features/auth/data/auth_repository.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  Future<Map<String , dynamic>?> getProfiledata() async {
    final token = await AuthRepository().getToken();
    print(token);
    final response = await http.get(
      Uri.parse('https://apptest.dokandemo.com/wp-json/wp/v2/users/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      print('this is profile data ${response.body}');
      return json.decode(response.body);
    } else {
      return null;
    }
  }
Future<dynamic> updateProfile(int id , Map<String , dynamic> fullName) async {
    print('this is user id - ${id} and this is full name - ${fullName}');
    final response = await http.post(
      Uri.parse('https://apptest.dokandemo.com/wp-json/wp/v2/users/${id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await AuthRepository().getToken()}'
      },
      body: jsonEncode(fullName),
      
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      print('failed updating user data -${response.body}');
    }
  }
}
