import 'dart:html';

import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/view/page/home_page.dart';
import 'data/repository/home_repository.dart';
import 'domain/repository/home_interface.dart';
import 'domain/usecase/home_usecase.dart';
import 'presentation/viewmodel/home_viewmodel.dart';

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
        ChildRoute('/notifications', child: (_, __) => NotificationsPage())
        ChildRoute('/profile', child: (_, __) => ProfilePage())
        ChildRoute('/search', child: (_, __) => SearchPage())

        ChildRoute('/', child: (_, __) => const LoginPage()),
        ChildRoute('/signup', child: (_, __) => const SignUpPage()),
        ChildRoute('/forgotPassword', child: (_, __) => const ForgotPasswordPage()),
        ModuleRoute('/home/', module: HomeModule()),
      ];
}
