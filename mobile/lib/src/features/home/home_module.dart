import 'package:InLaw/src/features/category/presentation/view/page/category_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/view/page/home_page.dart';
import 'data/repository/home_repository.dart';
import 'domain/repository/home_interface.dart';
import 'domain/usecase/home_usecase.dart';
import 'presentation/viewmodel/home_viewmodel.dart';

import 'package:InLaw/src/features/profile/presentation/view/page/profile_page.dart';
import 'package:InLaw/src/features/notifications/presentation/view/page/notifications_page.dart';
import 'package:InLaw/src/features/search/presentation/view/page/search_page.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory((i) => HomeViewModel()),
        Bind.factory((i) => HomeUseCase()),
        Bind.factory<IHome>((i) => HomeRepository()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const HomePage()),
        ChildRoute('/search', child: (_, __) => SearchPage()),
        ChildRoute('/notifications', child: (_, __) => NotificationPage()),
        ChildRoute('/profile', child: (_, __) => ProfilePage()),
        ChildRoute('/category', child: (_, __) => CategoryPage()),
      ];
}
