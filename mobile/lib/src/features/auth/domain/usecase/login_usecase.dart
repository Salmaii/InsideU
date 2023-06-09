import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';

import '../model/user.dart';
import '../repository/login_interface.dart';

class LoginUseCase {
  final repository = Modular.get<ILogin>();

  String? validateEmail(String email) {
    if (email.isEmpty) return 'email_required'.i18n();
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
      return 'email_invalid_format'.i18n();
    }
    return null;
  }

  String? validatePassword(String password, String email) {
    if (password.isEmpty) return 'password_required'.i18n();
    return null;
  }

  Future<AppUser> login(String email, String password) {
    return repository.login(AppUser(email, password));
  }
}
