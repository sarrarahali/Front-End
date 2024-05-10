
import 'package:boy/Screens/map.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/search.dart';
import 'package:boy/Screens/OrderDetailScreen.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:boy/read.dart/getcommande.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final commande = FirebaseAuth.instance.currentUser;
  List<String> docIDs = [];
  int pendingOrdersCount = 0;
  bool showPinView = false;

  @override
  void initState() {
    super.initState();
    getDocIdAndCountPendingOrders();
  }

  Future<void> getDocIdAndCountPendingOrders() async {
    await getDocId();
    countPendingOrders();
  }

  Future<void> getDocId() async {
    final snapshot = await FirebaseFirestore.instance.collection('commandes ').get();
    docIDs.clear();
    for (final document in snapshot.docs) {
      docIDs.add(document.reference.id);
    }
  }

  void countPendingOrders() {
    pendingOrdersCount = 0;
    for (final docID in docIDs) {
      FirebaseFirestore.instance.collection('commandes ').doc(docID).get().then((snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;
        if (data['status'] == 'pending') {
          setState(() {
            pendingOrdersCount++;
          });
        }
      }).catchError((error) {
        print('Error counting pending orders: $error');
      });
    }
  }

  void refuseCommand(String documentId) {
    // Remove the refused order from the list of document IDs
    setState(() {
      docIDs.remove(documentId);
      pendingOrdersCount--; // Decrease the count
    });
  }

  


 @override
  Widget build(BuildContext context) {
    CollectionReference commandes = FirebaseFirestore.instance.collection('commandes ');
    return Scaffold(
     appBar: !showPinView ? AppBar(
      automaticallyImplyLeading: false,
     ) : null, 
      
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
              if (showPinView) MapScreen(commandes:commandes),
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: !showPinView ? SearchWidget() : SizedBox(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: GlobalColors.mainColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                showPinView = false;
                              });
                            },
                            color: GlobalColors.mainColor,
                            icon: Image.asset("images/liste_icon.png"),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: GlobalColors.childmainColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              showPinView = true;
                            });
                          },
                          color: GlobalColors.mainColor,
                          icon: Image.asset(
                            "images/pin-icon.png",
                          ),
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
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: ' $pendingOrdersCount Nouveaux',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' commandes sont disponibles'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                      
                         physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder<DocumentSnapshot>(
                            future: commandes.doc(docIDs[index]).get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                if (data['status'] == 'pending') {
                                  return ListTile(
                                    title: GetCommande(documentId: docIDs[index], fromHomepage: true),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    // Any widgets you want to show when showPinView is true
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
  



/*import 'package:boy/read.dart/getcommande.dart';
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
  void acceptCommand(String documentId) async {
    await FirebaseFirestore.instance
        .collection('commandes')
        .doc(documentId)
        .update({'status': 'pending'});
  }
 
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
*/

