class AppUser {
  const AppUser(this.email, this.password, {this.token});

  final String email;
  final String? password;
  final String? token;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      AppUser(json['email'], json['password'], token: json['token']);
}
