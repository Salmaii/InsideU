import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/model/user.dart';
import '../../domain/repository/login_interface.dart';

class InvalidCredentialsException implements Exception {}

class UserNotFoundException implements Exception {
  final String email;

  UserNotFoundException(this.email);
}

class LoginRepository implements ILogin {
  @override
  Future<AppUser> login(AppUser user) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      );

      final token = await userCredential.user!.getIdToken();
      final domain = AppUser(user.email, null, token: token);
      return Future.value(domain);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException(user.email);
      } else if (e.code == 'wrong-password') {
        throw InvalidCredentialsException();
      } else {
        print('An error occurred: $e');
        throw Exception("Algo de errado aconteceu");
      }
    } catch (e) {
      print('An error occurred: $e');
      throw Exception("Algo de errado aconteceu");
    }
  }
}
