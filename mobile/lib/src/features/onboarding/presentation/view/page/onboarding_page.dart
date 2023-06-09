import 'package:InLaw/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, dynamic>> onboardingData = [
    {
      'text': 'Onboard_text1'.i18n(),
      'image': 'assets/images/onboarding_page_1.png',
      'animation': 'lib/assets/images/legal_statement.json',
    },
    {
      'text': 'Onboard_text2'.i18n(),
      'image': 'assets/images/onboarding_page_2.png',
      'animation': 'lib/assets/images/legal_statement.json',
    },
    {
      'text': 'Onboard_text3'.i18n(),
      'image': 'assets/images/onboarding_page_3.png',
      'animation': 'lib/assets/images/legal_statement.json',
    },
  ];

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return buildOnboardingPage(index);
                  },
                ),
              ),
              SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_currentPage != 0)
                    ElevatedButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Text(
                        'Back'.i18n(),
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  if (_currentPage != onboardingData.length - 1)
                    ElevatedButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Text(
                        'Next'.i18n(),
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  if (_currentPage == onboardingData.length - 1)
                    ElevatedButton(
                      onPressed: () {
                        Modular.to.pushReplacementNamed('/login/');
                      },
                      child: Text(
                        'Login'.i18n(),
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildPageIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOnboardingPage(int index) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/images/nameLogoNoBackground.png',
            width: 150,
            height: 150,
          ),
          SizedBox(height: 32.0),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Lottie.asset(
                onboardingData[index]['animation'],
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 48.0),
          Text(
            onboardingData[index]['text'],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0),
          ),
        ],
      ),
    );
  }

  List<Widget> buildPageIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < onboardingData.length; i++) {
      indicators.add(
        Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i ? Colors.blue : Colors.grey,
          ),
        ),
      );
    }

    return indicators;
  }
}
