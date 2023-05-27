import 'package:InLaw/src/features/auth/data/dto/user_dto.dart';
import 'package:dio/dio.dart';

import '../../domain/model/user.dart';
import '../../domain/repository/login_interface.dart';

class LoginRepository implements ILogin {
  @override
  Future<User> login(User user) async {
    final dto = UserDto.fromDomain(user);
    final response = await Dio().post(
      // TODO validate user
      'http://flutter-api.mocklab.io/auth/login',
      data: dto.toJson(),
    );
    // response.statusCode = 200;
    if (response.statusCode == 200) {
      final token = response.headers.value('Authorization');
      final domain = User(user.email, null, token: token);
      return Future.value(domain);
    } else {
      throw Exception("Usuário ou Senha Inválidos!");
    }
  }
}
