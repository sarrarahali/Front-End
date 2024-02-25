import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Sample data for notifications
  List<Map<String, dynamic>> notifications = [
    {
      'imagePath':'images/commande.png',
      'title': 'Livraison dans une heure',
      'subtitle': 'Nous vous informons que vous avez une livraison dans...',
      'time': '17h30',
    },
    {
      'imagePath': 'images/commande.png',
      'title': 'Nouvelle notification',
      'subtitle': 'Voici une nouvelle notification pour vous',
      'time': '18h45',
    },
    {
      'imagePath': 'images/commande.png',
      'title': 'Nouvelle notification',
      'subtitle': 'Voici une nouvelle notification pour vous',
      'time': '18h45',
    },
    {
      'imagePath': 'images/commande.png',
      'title': 'Nouvelle notification',
      'subtitle': 'Voici une nouvelle notification pour vous',
      'time': '18h45',
    },
    {
      'imagePath': 'images/commande.png',
      'title': 'Nouvelle notification',
      'subtitle': 'Voici une nouvelle notification pour vous',
      'time': '18h45',
    },
    {
      'imagePath': 'images/commande.png',
      'title': 'Nouvelle notification',
      'subtitle': 'Voici une nouvelle notification pour vous',
      'time': '18h45',
    },

    // Add more notification items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // First Row with Icon and Text
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Ionicons.arrow_back_outline), // Icon
                SizedBox(width: 10), // Space between icon and text
                Expanded(
                  child: Center(
                    child: Text(
                      "NOTIFICATIONS", // Text
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Space between first row and list view
            // List View
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
               
                itemCount: notifications.length, // Number of notification items
                itemBuilder: (context, index) {
                  // Example List Item
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Card(
                      elevation: 1,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15),
                        leading: Container(
                          width: 50,
                          height: 50,
                           color : GlobalColors.childmainColor,
                          child: Image.asset(
                            notifications[index]['imagePath'],
                            
                          ),
                        ),
                        title: Text(
                          notifications[index]['title'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(
                          notifications[index]['subtitle'],
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Ionicons.time_outline,
                              size: 14,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              notifications[index]['time'],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
