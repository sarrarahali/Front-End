
import 'package:boy/Screens/PendingScreen.dart';
import 'package:boy/Screens/aa.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boy/read.dart/getcommande.dart';
import 'package:boy/Widgets/Easystepper.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';

class GetCommande extends StatelessWidget {
  final String documentId;
  final bool fromHomepage;
  GetCommande({Key? key, required this.documentId, required this.fromHomepage}) : super(key: key);
  int currentIndex = 0; // Index of the currently displayed order

  List<String> orderIds = []; // List of order ids, you can populate this with order ids
  

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
               
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6),
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
  " ${data['status']}" + " ${DateFormat('dd/MM/yyyy').format(data['Date'].toDate())}", // Format the date here
  style: TextStyle(color: Colors.black),
),

                        IconButton(
  onPressed: () {
    


    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommandDetailsPage(
          
          data: data, 
          
          documentId: documentId, 
          source: 'HomeScreen', 
           
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
  





