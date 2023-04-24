import 'package:InLaw/src/features/auth/domain/model/sign_up_user.dart';

class SignUpUserDto {
  const SignUpUserDto(this.name, this.email, this.password);

  final String? name;
  final String? email;
  final String? password;

  factory SignUpUserDto.fromDomain(SignUpUser signUpUser) {
    return SignUpUserDto(signUpUser.name, signUpUser.email, signUpUser.password);
  }

  factory SignUpUserDto.fromJson(Map<String, dynamic> json) =>
      SignUpUserDto(json['name'], json['email'], json['password']);

  Map<String, dynamic> toJson() => {'name': name, 'email': email, 'password': password};
}
