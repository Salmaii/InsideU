import 'package:InLaw/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePageContents extends StatefulWidget {
  const HomePageContents({Key? key}) : super(key: key);

  @override
  State<HomePageContents> createState() => _HomePageContentsState();
}

class _HomePageContentsState extends State<HomePageContents>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _blockHeight = 100.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleBlockExpansion() {
    setState(() {
      _blockHeight =
          _blockHeight == 100.0 ? MediaQuery.of(context).size.height : 100.0;
    });
  }

  Widget _categoryBlock(
      BuildContext context, String categoryName, String imagePath) {
    return InkWell(
      onTap: () {
        _toggleBlockExpansion();
        Future.delayed(const Duration(milliseconds: 300), () {
          Modular.to.pushNamed('/home/category', arguments: categoryName);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: _blockHeight,
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
            Text(
              categoryName,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
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
          _categoryContainer,
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Categories')),
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
