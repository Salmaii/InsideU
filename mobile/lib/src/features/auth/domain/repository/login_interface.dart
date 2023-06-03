import '../model/user.dart';

abstract class ILogin {
  Future<AppUser> login(AppUser user);
}
