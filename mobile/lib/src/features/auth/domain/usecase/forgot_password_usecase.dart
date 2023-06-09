import 'package:localization/localization.dart';

class ForgotPasswordUseCase {
  String? validateEmail(String email) {
    if (email.isEmpty) return 'email_required'.i18n();
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
      return 'email_invalid_format'.i18n();
    }
    return null;
  }
}
