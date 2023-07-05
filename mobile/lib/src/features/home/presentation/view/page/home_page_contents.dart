import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageContents extends StatelessWidget {
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

  Widget _buildCategoryList(BuildContext context, List<String> categories) {
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          'lib/assets/images/nameLogoNoBackground.png',
          height: 32,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('categories').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No data found'));
                }
                List<String> categories = snapshot.data!.docs.map((doc) {
                  return doc.get('name') as String;
                }).toList();

                return _buildCategoryList(context, categories);
              },
            ),
          ],
        ),
      ),
    );
  }
}
