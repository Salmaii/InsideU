import 'package:InLaw/src/features/home/domain/repository/home_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import '../model/home_user.dart';

class HomeUseCase {
  final repository = Modular.get<IHome>();

  String? validateName(String name) {
    if (name.isEmpty) return 'name_required'.i18n();
    return null;
  }
 
  String? validateEmail(String email) {
    if (email.isEmpty) return 'email_required'.i18n();
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) return 'email_invalid_format'.i18n();          
    return null;
  }

  Future<HomeUser> home(String name,String email) {
    return repository.home(HomeUser(name, email));
  }
}