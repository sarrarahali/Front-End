// PendingScreen.dart
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:boy/Screens/aa.dart';
import 'package:boy/Widgets/Easystepper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:ionicons/ionicons.dart';

class PendingScreen extends StatefulWidget {
  final Function(String) acceptCommand;
  final Function(String) refuseCommand; // Add refuseCommand here


  PendingScreen({Key? key, required this.acceptCommand, required this.refuseCommand}) : super(key: key);

  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  late List<String> canceledOrderIds;
  late List<String> deliveredOrderIds;

  @override
  void initState() {
    super.initState();
    canceledOrderIds = [];
    deliveredOrderIds = [];

    // Fetch canceled order IDs
    FirebaseFirestore.instance.collection('CancelledOrders').get().then((querySnapshot) {
      setState(() {
        canceledOrderIds = querySnapshot.docs.map((doc) => doc['ID'].toString()).toList();
      });
    });

    // Fetch delivered order IDs
    FirebaseFirestore.instance.collection('DeliveredOrders').get().then((querySnapshot) {
      setState(() {
        deliveredOrderIds = querySnapshot.docs.map((doc) => doc['ID'].toString()).toList();
      });
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('commandes ')
          .where('status', whereIn: ['Ontheway', 'Arrived', 'processing', 'Confirm'])
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No pending orders'));
        } else {
          // Filter out canceled and delivered orders
          List<DocumentSnapshot> pendingOrders = snapshot.data!.docs.where((order) {
            var orderId = order['ID'].toString();
            return !canceledOrderIds.contains(orderId) && !deliveredOrderIds.contains(orderId);
          }).toList();

          // Calculate the count of pending orders
          int orderCount = pendingOrders.length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Add your text widget here
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'PENDING ORDER',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
              ),
              // Show the count of orders
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$orderCount ORDER${orderCount != 1 ? 'S' : ''}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: orderCount,
                  itemBuilder: (context, index) {
                    var order = pendingOrders[index];
                    var orderData = order.data() as Map<String, dynamic>;

                    // Render the order
                    return Card(
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
                                  "# ${orderData['ID']} " + "${orderData['NomPrenom']} ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  " ${orderData['Prix']} DT",
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
                                  " ${orderData['status']}" + " ${orderData['Date']}",
                                  style: TextStyle(color: Colors.black),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CommandDetailsPage(
                                          data: orderData,
                                          documentId: order.id,
                                          source: 'PendingScreen',
                                          acceptCommand: widget.acceptCommand,
                                          refuseCommand: widget.refuseCommand,
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
                          easy_stepper(
                            onStatusChanged: (status) {
                              // Update status in Firestore
                              order.reference.update({'status': status.toString().split('.').last});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    ),
  );
}

}
/*
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Add your text widget here
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'PENDING ORDER',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
         
        ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '5 ORDER',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
         
          
        ),
        
        Expanded(
      child:  
       StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('commandes ')
            .where('status', whereIn: ['Ontheway', 'Arrived', 'processing', 'Confirm'])
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No pending orders'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var order = snapshot.data!.docs[index];
                var orderData = order.data() as Map<String, dynamic>;
                var orderId = orderData['ID'].toString();

                // Check if orderId is in canceledOrderIds or deliveredOrderIds
                if (canceledOrderIds.contains(orderId) || deliveredOrderIds.contains(orderId)) {
                  // Skip rendering this order
                  return SizedBox.shrink();
                }

                // Render the order
                return Card(
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
                              "# ${orderData['ID']} " + "${orderData['NomPrenom']} ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " ${orderData['Prix']} DT",
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
                              " ${orderData['status']}" + " ${orderData['Date']}",
                              style: TextStyle(color: Colors.black),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => CommandDetailsPage(
      data: orderData,
      documentId: order.id,
      source: 'PendingScreen',
      acceptCommand: widget.acceptCommand,
       refuseCommand: widget.refuseCommand, 
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
                      easy_stepper(
                        onStatusChanged: (status) {
                          // Update status in Firestore
                          order.reference.update({'status': status.toString().split('.').last});
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
        )
      ]
        )
  
    );
  }
}











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






 
  
 



 
  
 

