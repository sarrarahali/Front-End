import 'package:boy/Screens/OrderDetailScreen.dart';
import 'package:boy/Screens/PendingScreen.dart';
import 'package:boy/Screens/aa.dart';
import 'package:boy/Screens/map.dart';
import 'package:flutter/material.dart';
import 'package:boy/model/commande_model.dart';

class MainPendingScreen extends StatefulWidget {
  @override
  State<MainPendingScreen> createState() => _MainPendingScreenState();
}
/*
class _MainPendingScreenState extends State<MainPendingScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator( 
        onGenerateRoute: (settings) {
          if (selectedIndex == 0) {
            return MaterialPageRoute(
              builder: (context) => PendingScreen(
           
              ),
            );
          } else if (selectedIndex == 1) {
            
            return MaterialPageRoute(
              builder: (context) => CommandDetailsPage(
      data: orderData,
      documentId: order.id,
      source: 'PendingScreen',
    ),
            );
          }
          return null;
        },
      ),
    );
  }
}
*/




class _MainPendingScreenState extends State<MainPendingScreen> {
  int selectedIndex = 0;

  Map<String, dynamic>? orderData; // Declare orderData as nullable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator( 
        onGenerateRoute: (settings) {
          if (selectedIndex == 0) {
            return MaterialPageRoute(
              builder: (context) => PendingScreen(orderData: orderData ?? {}),
            );
          } else if (selectedIndex == 1 && orderData != null) {
            return MaterialPageRoute(
              builder: (context) => CommandDetailsPage(
                data: orderData!,
                documentId: 'documentId', // Replace with the actual document ID
                source: 'PendingScreen',
                
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}




