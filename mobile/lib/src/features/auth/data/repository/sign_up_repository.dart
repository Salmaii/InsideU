import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/model/sign_up_user.dart';
import '../../domain/repository/sign_up_interface.dart';

class WeakPasswordException implements Exception {}

class EmailAlreadyInUseException implements Exception {}

class SignUpRepository implements ISignUp {
  @override
  Future<SignUpUser> signUp(SignUpUser signUpUser) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signUpUser.email,
        password: signUpUser.password!,
      );
      // Add username in FirebaseAuth db
      FirebaseAuth.instance.currentUser?.updateDisplayName(signUpUser.name);

      final token = await userCredential.user!.getIdToken();
      final domain =
          SignUpUser(signUpUser.name, signUpUser.email, null, token: token);
      return domain;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else {
        print('An error occurred: $e');
      }
      throw Exception("Algo de errado aconteceu");
    } catch (e) {
      print('An error occurred: $e');
      throw Exception("Algo de errado aconteceu");
    }
  }
}
