import 'package:InLaw/src/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:InLaw/src/theme.dart';

import '../../viewmodel/home_viewmodel.dart';

class HomePageContents extends StatefulWidget {
  const HomePageContents({Key? key}) : super(key: key);

  @override
  State<HomePageContents> createState() => _HomePageContentsState();
}

class _HomePageContentsState
    extends ModularState<HomePageContents, HomeViewModel> {
  late ThemeData _theme;

  Widget get _pageName => Container(
        width: double.infinity,
        height: 60,
        child: Text(
          'Home'.i18n(),
          style: kTitleBlack,
          textAlign: TextAlign.center,
        ),
      );

  Widget _categoryBlock(
      BuildContext context, String categoryName, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 100,
            width: 100,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: 10),
          TextButton(
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.all(0),
              textStyle: TextStyle(fontSize: 18),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/home/$categoryName');
            },
            child: Text(
              categoryName,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _categoryContainer => GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          _categoryBlock(
              context, 'Criminal', 'lib/assets/images/splashScreen.png'),
          _categoryBlock(
              context, 'Civil', 'lib/assets/images/splashScreen.png'),
          _categoryBlock(
              context, 'Constitutional', 'lib/assets/images/splashScreen.png'),
          _categoryBlock(
              context, 'Labor', 'lib/assets/images/splashScreen.png'),
          _categoryBlock(
              context, 'Business', 'lib/assets/images/splashScreen.png'),
          _categoryBlock(
              context, 'Environmental', 'lib/assets/images/splashScreen.png'),
          _categoryBlock(context, 'Intellectual Property',
              'lib/assets/images/splashScreen.png'),
          _categoryBlock(
              context, 'Family', 'lib/assets/images/splashScreen.png'),
          _categoryBlock(
              context, 'International', 'lib/assets/images/splashScreen.png'),
          _categoryBlock(context, 'Tax', 'lib/assets/images/splashScreen.png'),
          _categoryBlock(
              context, 'Real Estate', 'lib/assets/images/splashScreen.png'),
          _categoryBlock(context, 'Information Technology',
              'lib/assets/images/splashScreen.png'),
        ],
      );

  Widget get _formBuild => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5),
          _pageName,
          _categoryContainer,
        ],
      );

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('InLaw')),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.88,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 242, 242, 242),
          ),
          child: _categoryContainer,
        ),
      ),
    );
  }
}
