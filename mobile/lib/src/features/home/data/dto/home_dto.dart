import 'package:InLaw/src/features/home/domain/model/home_user.dart';

class HomeUserDto {
  const HomeUserDto(this.name, this.email);

  final String? name;
  final String? email;

  factory HomeUserDto.fromDomain(HomeUser homeUser) {
    return HomeUserDto(homeUser.name, homeUser.email);
  }

  factory HomeUserDto.fromJson(Map<String, dynamic> json) =>
      HomeUserDto(json['name'], json['email']);

  Map<String, dynamic> toJson() => {'name': name, 'email': email};
}
