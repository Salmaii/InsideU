class HomeUser {
  const HomeUser(this.name, this.email, {this.token});

  final String name;
  final String email;
  final String? token;

  factory HomeUser.fromJson(Map<String, dynamic> json) =>
      HomeUser(json['name'] ,json['email'], token: json['token']);
}
