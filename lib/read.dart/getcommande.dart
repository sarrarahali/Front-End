


import 'package:boy/Screens/PendingScreen.dart';
import 'package:boy/Screens/aa.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boy/read.dart/getcommande.dart';
import 'package:boy/Widgets/Easystepper.dart';
import 'package:ionicons/ionicons.dart';

class GetCommande extends StatelessWidget {
  final String documentId;
  final bool fromHomepage;

  GetCommande({Key? key, required this.documentId, required this.fromHomepage}) : super(key: key);
  int currentIndex = 0; // Index of the currently displayed order

  List<String> orderIds = []; // List of order ids, you can populate this with order ids
  void acceptCommand(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('commandes ')
          .doc(documentId)
          .update({'status': 'Ontheway'});
      print('Command accepted successfully!');
    } catch (e) {
      print('Error accepting command: $e');
    }
  }
void refuseCommand(String documentId) async {
  try {
    await FirebaseFirestore.instance
        .collection('commandes ')
        .doc(documentId)
        .update({'status': 'Refused'});
    print('Command refused successfully!');
  } catch (e) {
    print('Error refusing command: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    CollectionReference commandes = FirebaseFirestore.instance.collection('commandes ');

    return FutureBuilder<DocumentSnapshot>(
      future: commandes.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return 
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "# ${data['ID']} " + "${data['NomPrenom']}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " ${data['Prix']} DT",
                          style: TextStyle(
                            color: GlobalColors.mainColorbg,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          " ${data['status']}" + " ${data['Date']}",
                          style: TextStyle(color: Colors.black),
                        ),
                        IconButton(
  onPressed: () {
    // Navigate to the command details page and pass necessary parameters
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommandDetailsPage(
          data: data, // Provide the data for the order
          acceptCommand: acceptCommand, 
          refuseCommand:refuseCommand,// Provide the acceptCommand function
          documentId: documentId, // Provide the documentId of the order
          source: 'HomeScreen', // Specify the source
        ),
      ),
    );
  },
  icon: Icon(
    Ionicons.chevron_forward_outline,
    color: GlobalColors.iconColor,
  ),
),

                        
                      ],
                    ),
                  ),
                   if (!fromHomepage)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: GlobalColors.localisationbg,
                          ),
                          child: Icon(Ionicons.location_outline, color: GlobalColors.localisation),
                        ),
                        SizedBox(width:8.0),
                        Flexible(
        child: Text(
          "${data['Localisation']}",
          style: TextStyle(fontSize: 16.0), // Adjust font size as needed
          overflow: TextOverflow.ellipsis, // Specify how to handle overflow
          maxLines: 3, // Specify maximum number of lines before truncating with ellipsis
        ),
      ),
                          
                         
                        ],
                      ),
                    ),
                ],
              ),
            
            );
          } else {
            return Text("Document does not exist.");
          }
        }
        return CircularProgressIndicator()
        ;
      });}
      }
  





