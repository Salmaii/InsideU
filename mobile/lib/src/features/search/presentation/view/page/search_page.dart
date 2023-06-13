import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _showSearchBar = false;
  List<String> searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remover o ícone de voltar
        backgroundColor: _showSearchBar ? Colors.white : Color(0xFF011C2E),
        title: _showSearchBar
            ? Container(
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Pesquisar',
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onChanged: (value) {
                          // TODO Implementar lógica da pesquisa
                        },
                      ),
                    ),
                    if (_showSearchBar)
                      IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            _showSearchBar = false;
                            _searchController.clear();
                          });
                        },
                      ),
                  ],
                ),
              )
            : Text('Search'),
        actions: [
          if (!_showSearchBar)
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _showSearchBar = !_showSearchBar;
                });
              },
            ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index]),
                  onTap: () {
                    // TODO implementar a lógica para exibir mais detalhes do resultado da pesquisa
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
