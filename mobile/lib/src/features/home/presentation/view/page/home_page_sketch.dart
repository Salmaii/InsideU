import 'package:flutter/material.dart';

class HomePageBase extends StatelessWidget {
  const HomePageBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey[50],
        child: Center(
          child: Text(
            'CREATE YOUR HOME PAGE HERE!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
    );
  }
}