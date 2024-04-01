

import 'package:boy/Screens/OrderDetailScreen.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/Easystepper.dart';

import 'package:boy/model/commande_model.dart';
import 'package:boy/read.dart/getcommande.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PendeingScreen extends StatefulWidget {
  const PendeingScreen({super.key});

  @override
  State<PendeingScreen> createState() => _PendeingScreenState();
}

class _PendeingScreenState extends State<PendeingScreen> {
   final commande = FirebaseAuth.instance.currentUser;

  List<String> docIDs = [];

 


  // Function to get document IDs
  Future<void> getDocId() async {
   await FirebaseFirestore.instance.collection('commandes ').get().then((snapshot) => snapshot.docs.forEach((document) {
    print(document.reference);
    docIDs.add(document.reference.id);
    }));
   
  }
  final double _min = 0;
final double _max = 100;

   double _sliderValue = 50.0; 


  
  static List<Commande> mainCommandeList = [];
  List<Commande> displayList = List.from(mainCommandeList);
  
  var activeStep = 0;

  void updateList(String value) {}
  @override

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:   CrossAxisAlignment.start,
          children: [
            const Text("PENDING ORDER ", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),),
             const Text("29 order ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
            const SizedBox(height: 30),
      
Expanded( 

  child: FutureBuilder(
    future: getDocId(), 
    builder: (context, index) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: docIDs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
               GetCommande(documentId: docIDs[index], fromHomepage: false), // Assuming this is not the homepage

              
              ],
            ),
          );
        },
      );
    }
  ),
),




          ]
        )
        )
        );
}




  }




/*

----------------------


import 'package:boy/Screens/OrderDetailScreen.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/Easystepper.dart';

import 'package:boy/model/commande_model.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PendeingScreen extends StatefulWidget {
  const PendeingScreen({super.key});

  @override
  State<PendeingScreen> createState() => _PendeingScreenState();
}

class _PendeingScreenState extends State<PendeingScreen> {
  final double _min = 0;
final double _max = 100;

   double _sliderValue = 50.0; 


  
  static List<Commande> mainCommandeList = [];
  List<Commande> displayList = List.from(mainCommandeList);
  
  var activeStep = 0;

  void updateList(String value) {}
  @override

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:   CrossAxisAlignment.start,
          children: [
            const Text("PENDING ORDER ", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),),
             const Text("29 order ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
            const SizedBox(height: 30),
      




Expanded(
  child: ListView.builder(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: dates.length,
    itemBuilder: (BuildContext context, int index) => Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '#${numid[index]} ${IDNP[index]}',
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 110,),
                  Text(
                    '${PRIX[index]}',
                    style: TextStyle(color: GlobalColors.mainColorbg, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Pending ${dates[index]}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  Row(
                    children: [
                      const Text(
                        "à la livraison",
                        style: TextStyle(color: Colors.black),
                      ),
IconButton(
  onPressed: () {
  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => OrderDetailsScreen(
      index: index,
      commande: Commande(
        PRIX[index],
        int.parse(numid[index]),
        IDNP[index],
        DateTime.now(),
        details[index],
        localisation[index],
        KM[index],
        time[index],
        Comment[index],
      ),
      source: 'PendeingScreen', // Pass the source parameter
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
                ],
              ),
              const SizedBox(height: 10),

              const easy_stepper(),
            ],
          ),
        ),
      ),
    ),
  ),
),

         
          ],
          
        ),
      ),
    );
  }
}
*/






 
  
 



 
  
 

