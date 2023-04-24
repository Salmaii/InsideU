import 'package:InLaw/src/features/auth/domain/repository/sign_up_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import '../model/sign_up_user.dart';

class SignUpUseCase {
  final repository = Modular.get<ISignUp>();

  String? validateName(String name) {
    if (name.isEmpty) return 'name_required'.i18n();
    return null;
  }
 
  String? validateEmail(String email) {
    if (email.isEmpty) return 'email_required'.i18n();
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) return 'email_invalid_format'.i18n();          
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return 'password_required'.i18n();
    if (password.length < 8) return 'password_invalid_lenght'.i18n();
    if (!password.contains(RegExp(r"[a-z]"))) return 'password_invalid_upper_case'.i18n();
    if (!password.contains(RegExp(r"[A-Z]"))) return 'password_invalid_lower_case'.i18n();
    if (!password.contains(RegExp(r"[0-9]"))) return 'password_invalid_number'.i18n();
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return 'password_invalid_special'.i18n();
    return null;
  }

  Future<SignUpUser> signUp(String name,String email, String password) {
    return repository.signUp(SignUpUser(name, email, password));
  }
}
