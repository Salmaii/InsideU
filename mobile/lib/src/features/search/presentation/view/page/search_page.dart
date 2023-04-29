import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _showSearchBar = false;
  List<String> searchResults = [];
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // remover o botao de voltar
        // e fazer com que o tittle da app bar fique na esquerda
        // e os icones de filtro e fechar na direita
        backgroundColor: _showSearchBar ? Colors.white : Color(0xFF011C2E),
        title: !_showSearchBar
            ? Text('Search')
            : TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Pesquisar',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  // Implemente aqui a lógica de pesquisa
                },
              ),
        centerTitle: true,
        actions: [
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
          if (!_showSearchBar)
            IconButton(
              icon: Icon(Icons.filter_alt),
              onPressed: () {
                setState(() {
                  _showSearchBar = !_showSearchBar;
                });
              },
            ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index]),
                  onTap: () {
                    // Aqui você pode implementar a lógica para
                    // exibir mais detalhes do resultado da pesquisa
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
