import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
decoration: BoxDecoration(
 borderRadius: const BorderRadius.all(Radius.circular(8)),
 color: Colors.white,
 border: Border.all(color: Colors.grey),
),
padding: const EdgeInsets.symmetric(horizontal: 8) ,
child:const TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        icon: Icon(Icons.search, color: Colors.black, ),
        hintText: "Chercher N° commande",
      ),
    ),



    );

  }
}