class User {
  final String login;
  final String name;
  final int followers;
  final String avatarUrl;

  User({
    required this.login,
    required this.name,
    required this.followers,
    required this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'] ?? '',
      name: json['name'] ?? '',
      followers: json['followers'] ?? 0,
      avatarUrl: json['avatar_url'] ?? '',
    );
  }
}