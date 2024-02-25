import 'package:boy/Screens/OrderDetailScreen.dart';
import 'package:boy/Screens/home_page.dart';
import 'package:flutter/material.dart';

class MainScreenhome extends StatefulWidget {
  // ... rest of your MainScreen code

  @override
  State<MainScreenhome> createState() => _MainScreenhomeState();
}

class _MainScreenhomeState extends State<MainScreenhome> {
  // ... rest of your _MainScreenState code
int selectedindex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Navigator(
        onGenerateRoute: (settings) {
          if (selectedindex == 0) {
            
            return MaterialPageRoute(
              builder: (context) => HomeScreen(),
            );
          } else if (selectedindex == 1) {
           
            return MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(
                index: settings.arguments as int,
              ),
            );
          }
          return null;
        },
      ),
     
    );
  }
}
