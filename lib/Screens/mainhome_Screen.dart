
import 'package:flutter/material.dart';
import 'package:boy/Screens/home_page.dart';
import 'package:boy/Screens/OrderDetailScreen.dart'; 
import 'package:boy/model/commande_model.dart';

class MainScreenhome extends StatefulWidget {
  @override
  State<MainScreenhome> createState() => _MainScreenhomeState();
}

class _MainScreenhomeState extends State<MainScreenhome> {
  int selectedindex = 0;

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
         
            Commande commande = Commande(
              PRIX[settings.arguments as int],
              int.parse(numid[settings.arguments as int]),
              IDNP[settings.arguments as int],
              DateTime.parse(dates[settings.arguments as int]),
              details[settings.arguments as int],
              localisation[settings.arguments as int],
              time[settings.arguments as int],
              KM[settings.arguments as int],
               Comment[settings.arguments as int],
            );

            return MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(
                index: settings.arguments as int,
                commande: commande, source: 'MainScreenhome', 
              ),
            );
          }
         
         return null;
        },


        
      ),
    );
  }
}
