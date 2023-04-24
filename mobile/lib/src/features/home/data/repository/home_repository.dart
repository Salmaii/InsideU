import 'package:dio/dio.dart';
import 'package:InLaw/src/features/home/data/dto/home_dto.dart';
import '../../domain/model/home_user.dart';
import '../../domain/repository/home_interface.dart';

class HomeRepository implements IHome {
  @override
  Future<HomeUser> home(HomeUser homeUser) async {
    final dto = HomeUserDto.fromDomain(homeUser);
    final response = await Dio().post( 
      'http://flutter-api.mocklab.io/auth/login',
      data: dto.toJson(),
    );
    if (response.statusCode == 200) {
      final token = response.headers.value('Authorization');
      final domain = HomeUser(homeUser.name, homeUser.email, token: token);
      return Future.value(domain);
    } else {
      throw Exception("Algo de errado aconteceu");
    }
  }
}