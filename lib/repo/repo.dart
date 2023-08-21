import 'dart:convert';
import 'package:github_users/model/user.dart';
import 'package:http/http.dart' as http;


class UserRepo {

  Future<List<User>> searchUsersByUsername(String username) async {
    final response = await http.get(Uri.parse('https://api.github.com/search/users?q=$username'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final users = data['items'].map<User>((userData) => User.fromJson(userData)).toList();
      return users; // Return a Future<List<User>>
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}