import '../model/sign_up_user.dart';

abstract class ISignUp {
  Future<SignUpUser> signUp(SignUpUser signUpUser);
}
