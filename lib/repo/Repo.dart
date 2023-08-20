import 'dart:convert';
import 'package:github_users/model/user.dart';
import 'package:http/http.dart' as http;


class UserRepo {
  String githubUrl = 'https://api.github.com/search/users';

  Future<List<User>> searchUser({String? searchQuery}) async {
    final response = await http.get(Uri.parse('$githubUrl?q=$searchQuery'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final usersJson = data['items'] as List<dynamic>;
      final users = usersJson.map((userJson) => User.fromJson(userJson)).toList();
      return users;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}