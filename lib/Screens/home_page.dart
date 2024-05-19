import 'package:boy/Screens/map.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/search.dart';
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
  late TextEditingController _searchController;
  bool isIdNotFound = false; // Track whether the entered ID is not found

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
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
    String userId = FirebaseAuth.instance.currentUser!.uid;
    for (final docID in docIDs) {
      FirebaseFirestore.instance.collection('commandes ').doc(docID).get().then((snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;
        if (data['status'] == 'pending' && !(data['refusedBy'] ?? [] ).contains(userId)   ) {
          setState(() {
            pendingOrdersCount++;
          });
        }
      }).catchError((error) {
        print('Error counting pending orders: $error');
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference commandes = FirebaseFirestore.instance.collection('commandes ');

    // Check if there are pending orders
    bool hasPendingOrders = pendingOrdersCount > 0;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            if (showPinView && hasPendingOrders)
              MapScreen(commandes: commandes),
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: !showPinView
                            ? SearchWidget(
                                searchController: _searchController,
                                onSearchTextChanged: (text) {
                                  // Perform search operation here
                                  setState(() {
                                    // Update UI based on search text
                                  });
                                },
                              )
                            : SizedBox(),
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
                      "NEW ORDER",
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
                            "Tous les commandes",
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
                    if (hasPendingOrders) // Display orders if there are pending orders
                      Expanded(
                        child: ListView.builder(
  itemCount: docIDs.length,
  itemBuilder: (context, index) {
    return FutureBuilder<DocumentSnapshot>(
      future: commandes.doc(docIDs[index]).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          String userId = FirebaseAuth.instance.currentUser!.uid;
          // Check if the order is pending, not refused by the current user, and not accepted by any user
          if (data['status'] == 'pending' && 
              !(data['refusedBy'] ?? []).contains(userId) && 
              (data['acceptedByUserId'] == null || data['acceptedByUserId'].isEmpty)) {
            return ListTile(
              title: GetCommande(documentId: docIDs[index], fromHomepage: true),
            );
          }
        }
        return SizedBox();
      },
    );
  },
),

                      ),
                  ],
                  if (showPinView && !hasPendingOrders) // Display message if no pending orders and map view is active
                    Expanded(
                      child: Center(
                        child: Text(
                          "There are no orders available.",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  }
/*----
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
   late TextEditingController _searchController;
   bool isIdNotFound = false; // Track whether the entered ID is not found

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
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

 

   @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }



@override
Widget build(BuildContext context) {
  CollectionReference commandes = FirebaseFirestore.instance.collection('commandes ');

  // Check if there are pending orders
  bool hasPendingOrders = pendingOrdersCount > 0;

  return Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          if (showPinView && hasPendingOrders)
            MapScreen(commandes: commandes),
          Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: !showPinView
                          ? SearchWidget(
                              searchController: _searchController,
                              onSearchTextChanged: (text) {
                                // Perform search operation here
                                setState(() {
                                  // Update UI based on search text
                                });
                              },
                            )
                          : SizedBox(),
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
                  
                  
                  if (hasPendingOrders) // Display orders if there are pending orders
                    Expanded(
                  child: ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<DocumentSnapshot>(
                        future: commandes.doc(docIDs[index]).get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

                            // Get current user's ID
                            String userId = FirebaseAuth.instance.currentUser!.uid;

                            // Check if the order is pending and not refused by the current user
                            if (data['status'] == 'pending' && !(data['refusedBy'] ?? []).contains(userId)) {
                              return ListTile(
                                title: GetCommande(documentId: docIDs[index], fromHomepage: true),
                              );
                            }
                          }
                          return SizedBox();
                        },
                      
                          );
                        },
                      ),
                    ),
                ],
                if (showPinView && !hasPendingOrders) // Display message if no pending orders and map view is active
                  Expanded(
                    child: Center(
                      child: Text(
                        "There are no orders available.",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}




 appBar: !showPinView ? AppBar(
      automaticallyImplyLeading: false,
     ) : null, 

*/
