class SignUpUser {
  const SignUpUser(this.name, this.email, this.password, {this.token});

  final String name;
  final String email;
  final String? password;
  final String? token;

  factory SignUpUser.fromJson(Map<String, dynamic> json) =>
      SignUpUser(json['name'] ,json['email'], json['password'], token: json['token']);
}
