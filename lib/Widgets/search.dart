import 'package:flutter/material.dart';

/*
class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;

  const SearchWidget({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: searchController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.black),
          hintText: "Chercher N° commande",
        ),
      ),
    );
  }
}*/


import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchTextChanged; // Callback to notify parent widget of text change

  const SearchWidget({
    Key? key,
    required this.searchController,
    required this.onSearchTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: searchController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.black),
          hintText: "Chercher N° commande",
        ),
        onChanged: (text) {
          // Notify parent widget about text change
          onSearchTextChanged(text);
        },
      ),
    );
  }
}
