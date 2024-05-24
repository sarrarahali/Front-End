import 'package:boy/Screens/aa.dart';
import 'package:boy/Screens/map.dart';
import 'package:flutter/material.dart';
import 'package:boy/Screens/home_page.dart';

class MainScreenhome extends StatefulWidget {
  @override
  State<MainScreenhome> createState() => _MainScreenhomeState();
}

class _MainScreenhomeState extends State<MainScreenhome> {
  int selectedIndex = 0;
   void updateIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator( 
        onGenerateRoute: (settings) {
          if (selectedIndex == 0) {
            return MaterialPageRoute(
              builder: (context) => HomeScreen()
            );
           } else if (selectedIndex == 1 ) {
            // Provide the required 'data' argument
            Map<String, dynamic> data = {
              'key': 'value', // Replace with your actual data
            };

            return MaterialPageRoute(
              builder: (context) => CommandDetailsPage(
                data: data, // Pass the 'data' argument
                documentId: 'documentId', // Replace with the actual document ID
                source: 'HomeScreen',
              
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
