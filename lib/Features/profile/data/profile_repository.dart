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

  updateProfile(int id) async {
    final response = await http.post(
      Uri.parse('https://apptest.dokandemo.com/wp-json/wp/v2/users/me/${id}'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print('this is user update response - ${response.body}');
    } else {
      print('failed updating user data -${response.body}');
    }
  }
}
