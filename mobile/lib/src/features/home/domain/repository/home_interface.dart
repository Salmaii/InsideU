import '../model/home_user.dart';

abstract class IHome {
  Future<HomeUser> home(HomeUser user);
}
