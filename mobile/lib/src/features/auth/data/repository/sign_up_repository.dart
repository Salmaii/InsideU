import 'package:dio/dio.dart';
import 'package:InLaw/src/features/auth/data/dto/sign_up_dto.dart';
import '../../domain/model/sign_up_user.dart';
import '../../domain/repository/sign_up_interface.dart';

class SignUpRepository implements ISignUp {
  @override
  Future<SignUpUser> signUp(SignUpUser signUpUser) async {
    final dto = SignUpUserDto.fromDomain(signUpUser);
    final response = await Dio().post( 
      'http://flutter-api.mocklab.io/auth/login',
      data: dto.toJson(),
    );
    if (response.statusCode == 200) {
      final token = response.headers.value('Authorization');
      final domain = SignUpUser(signUpUser.name, signUpUser.email, null, token: token);
      return Future.value(domain);
    } else {
      throw Exception("Algo de errado aconteceu");
    }
  }
}
