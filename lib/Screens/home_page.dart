
import 'package:boy/read.dart/getcommande.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/search.dart';
import 'package:boy/Screens/OrderDetailScreen.dart';
import 'package:boy/model/commande_model.dart';
import 'package:ionicons/ionicons.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //zidt athouma

  final commande = FirebaseAuth.instance.currentUser;

  List<String> docIDs = [];

  // Function to get document IDs
  Future<void> getDocId() async {
   await FirebaseFirestore.instance.collection('commandes ').get().then((snapshot) => snapshot.docs.forEach((document) {
    print(document.reference);
    docIDs.add(document.reference.id);
    }));
   
  }
  //zidt athouma
 
  bool showPinView = false;

  @override
  Widget build(BuildContext context) {
       CollectionReference commandes = FirebaseFirestore.instance.collection('commandes ');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: !showPinView ? SearchWidget(): SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: GlobalColors.mainColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:IconButton( onPressed: () {
                        setState(() {
                          showPinView = false;
                        });
                      },
                 
                 
                 color: GlobalColors.mainColor,
                                   icon: Image.asset("images/liste_icon.png",
)             
                 
               ),
                    
                    
                     
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: GlobalColors.childmainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:  IconButton(
                 
                 onPressed: () {
                   setState(() {
                        showPinView = true;
                      });
                 },
                 color: GlobalColors.mainColor,
                                   icon: Image.asset("images/pin-icon.png",
)             
                 
               ),
               
                  
                ),
              ],
            ),
            if (!showPinView) ...[
              SizedBox(height: 20),
              Text(
                "NEW ORDER ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(
                      text: '40 Nouveaux ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'commandes sont disponibles'),
                  ],
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Tous les commandes ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset("images/filtre.png"),
                  ),
                ],
              ),
              Expanded(
                 child: 
                 FutureBuilder<void>(
  future: getDocId(), 
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator(); // or any loading indicator
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return ListView.builder(
        itemCount: docIDs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: GetCommande(documentId: docIDs[index], fromHomepage: true),
          );
        },
      );
    }
  }
)

              
              ),
            ],
          ],
        ),
      ),
    );
  }
}


