import 'package:InLaw/src/features/category/presentation/view/page/category_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CategoryModule extends Module {
  // @override
  // List<Bind<Object>> get binds => [

  //     ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (_, args) => CategoryPage(
                  titulo: args.data as String,
                )),
      ];
}
