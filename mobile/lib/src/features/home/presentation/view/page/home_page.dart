import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';

import 'package:InLaw/src/features/profile/presentation/view/page/profile_page.dart';
import 'package:InLaw/src/features/notifications/presentation/view/page/notifications_page.dart';
import 'package:InLaw/src/features/search/presentation/view/page/search_page.dart';

import 'home_page_contents.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePageContents();
      case 1:
        return SearchPage();
      case 2:
        return NotificationPage();
      case 3:
        return ProfilePage();
      default:
        return const HomePageContents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_currentPageIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black38,
        fixedColor: Colors.blueGrey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentPageIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
