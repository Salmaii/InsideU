import 'package:flutter_modular/flutter_modular.dart';

import 'package:InLaw/src/features/onboarding/onboarding_module.dart';
import 'features/auth/auth_module.dart';
import 'features/home/home_module.dart';
import 'package:InLaw/src/features/category/category_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: OnBoardingModule()),
        ModuleRoute('/auth/', module: AuthModule()),
        ModuleRoute('/home/', module: HomeModule()),
        ModuleRoute('/category/', module: CategoryModule()),
      ];
}

/*
  Declare All Module Routes In app_module

  Use /ModuleRouteName/ to ModuleRoutes
  Use /ChildRouteName/ to ChildRoutes
*/