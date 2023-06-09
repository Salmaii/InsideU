import 'package:flutter_modular/flutter_modular.dart';

import '../auth/data/repository/login_repository.dart';
import '../auth/domain/repository/login_interface.dart';
import 'presentation/view/page/home_page.dart';

import 'package:InLaw/src/features/profile/presentation/view/page/profile_page.dart';
import 'package:InLaw/src/features/notifications/presentation/view/page/notifications_page.dart';
import 'package:InLaw/src/features/search/presentation/view/page/search_page.dart';

import '../auth/presentation/viewmodel/login_viewmodel.dart';
import '../auth/domain/usecase/login_usecase.dart';

import 'package:InLaw/src/features/category/category_module.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory((i) => LoginViewModel()),
        Bind.factory((i) => LoginUseCase()),
        Bind.factory<ILogin>((i) => LoginRepository())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const HomePage()),
        ChildRoute('/search', child: (_, __) => SearchPage()),
        ChildRoute('/notifications', child: (_, __) => NotificationPage()),
        ChildRoute('/profile', child: (_, __) => ProfilePage()),
        ModuleRoute('/category/', module: CategoryModule()),
      ];
}
