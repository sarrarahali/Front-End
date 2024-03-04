import 'package:flutter/material.dart';
import 'package:boy/Screens/home_page.dart';

class MainScreenhome extends StatefulWidget {
  @override
  State<MainScreenhome> createState() => _MainScreenhomeState();
}

class _MainScreenhomeState extends State<MainScreenhome> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        onGenerateRoute: (settings) {
          if (selectedIndex == 0) {
            return MaterialPageRoute(
              builder: (context) => HomeScreen(),
            );
          } else if (selectedIndex == 1) {
            return MaterialPageRoute(
              builder: (context) => HomeScreen(),
            );
          }
          return null;
        },
      ),
    );
  }
}
