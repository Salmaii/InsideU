import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePageContents extends StatelessWidget {
  final List<String> categories = [
    'Criminal',
    'Civil',
    'Constitutional',
    'Labor',
    'Business',
    'Environmental',
    'Intellectual Property',
    'Family',
    'International',
    'Tax',
    'Real Estate',
    'Information Technology',
    'Other'
  ];

  HomePageContents({Key? key}) : super(key: key);

  void _navigateToCategory(BuildContext context, String categoryName) {
    Modular.to.pushNamed('/home/category', arguments: categoryName);
  }

  Widget _buildCategoryTile(BuildContext context, String categoryName) {
    return GestureDetector(
      onTap: () {
        _navigateToCategory(context, categoryName);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            categoryName,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: categories
            .map((category) => _buildCategoryTile(context, category))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // Remove o ícone de voltar
        centerTitle: true,
        title: Image.asset(
          'lib/assets/images/nameLogoNoBackground.png',
          height: 32,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Categorias',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: _buildCategoryList(context),
          ),
        ],
      ),
    );
  }
}
