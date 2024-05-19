/*import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  
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
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
               
                itemCount: notifications.length, 
                itemBuilder: (context, index) {
                 
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
*/
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/*class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  _notification createState() => _notification();
}

class _notification extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Center(
        child: Text("No notifications yet."),
      ),
    );
  }
}*/

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
      // Save this token on your backend to send notifications to this device
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Une commande en attente'),
              content: Text(message.notification!.body ?? ''),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Center(
        child: Text("No notifications yet."),
      ),
    );
  }
}