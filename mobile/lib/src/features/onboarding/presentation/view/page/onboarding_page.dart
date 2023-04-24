import 'package:InLaw/src/app_styles.dart';
import 'package:InLaw/src/features/auth/domain/model/onboard_data.dart';
import 'package:InLaw/src/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  int currentPage = 0;

  PageController _pageController = PageController();

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      duration: const Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kSecondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Scaffold(
      backgroundColor: const Color(0xFF011C2E),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: 3,
                itemBuilder: (context, index) => Column(
                  children: [
                    SizedBox(
                      height: sizeV * 6, //5
                    ),
                    Container(
                        height: sizeV * 8,
                        child: Image.asset(
                          onboardingContents[index].image,
                        )),
                    SizedBox(height: sizeV * 6 //5
                        ),
                    Container(
                      height: sizeV * 40, //40
                      child: Lottie.asset(
                          "lib/assets/images/legal_statement.json"),
                    ),
                    SizedBox(
                      height: sizeV * 6, //5
                    ),
                    Text(
                      onboardingContents[index].title.i18n(),
                      style: kBodyText1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: sizeV * 6, //5
                    ),
                    _OnboardingTaskB,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _OnboardingTaskB => Expanded(
        flex: 1,
        child: Column(
          children: [
            currentPage == onboardingContents.length - 1
                ? MyTextButton(
                    buttonName: 'Get Started'.i18n(),
                    onpressed: () {
                      Navigator.pop(context);
                      Modular.to.pushNamed('/login/');
                    },
                    btColor: kPrimaryColor,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OnboardingButton(
                        name: 'Skip'.i18n(),
                        onPressed: () {
                          //Navigator.pop(context);
                          // Modular.to.pushNamed('/login/');
                          Modular.to.pushReplacementNamed('/login/');
                        },
                      ),
                      Row(
                        children: List.generate(onboardingContents.length,
                            (index) => dotIndicator(index)),
                      ),
                      OnboardingButton(
                        name: 'Next'.i18n(),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ],
                  ),
          ],
        ),
      );
}

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key,
    required this.buttonName,
    required this.onpressed,
    required this.btColor,
  }) : super(key: key);
  final String buttonName;
  final VoidCallback onpressed;
  final Color btColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: SizeConfig.blockSizeH! * 10,
        width: SizeConfig.blockSizeH! * 100,
        child: TextButton(
          onPressed: onpressed,
          child: Text(
            buttonName,
            style: kBodyText1,
          ),
          style: TextButton.styleFrom(
            backgroundColor: btColor,
          ),
        ),
      ),
    );
  }
}

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);
  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      splashColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          name,
          style: kBodyText1,
        ),
      ),
    );
  }
}
