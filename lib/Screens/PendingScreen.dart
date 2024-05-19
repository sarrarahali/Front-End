

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:boy/Screens/aa.dart';
import 'package:boy/Widgets/Easystepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';

class PendingScreen extends StatefulWidget {
  final Map<String, dynamic> orderData;

  PendingScreen({Key? key,required this.orderData }) : super(key: key);

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
    .where('status', whereIn: ['pending','Ontheway', 'Arrived', 'processing', 'Confirm'])
    .where('acceptedByUserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .snapshots(),
 

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            print('No pending orders for the current user.');
            return Center(child: Text('No pending orders'));
          } else {
       
            
// Filter orders based on whether they have been accepted by the current user
var pendingOrders = snapshot.data!.docs.where((order) {
    var orderData = order.data() as Map<String, dynamic>;
    return orderData['status'] == 'pending' && orderData['acceptedByUserId'] == FirebaseAuth.instance.currentUser!.uid;
}).toList();

            // Calculate the count of pending orders
            int orderCount = pendingOrders.length;

            print('Found $orderCount pending orders for the current user.');

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
                                    " ${orderData['status']}" + " ${DateFormat('dd/MM/yyyy').format(orderData['Date'].toDate())}",
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
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:boy/Screens/aa.dart';
import 'package:boy/Widgets/Easystepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';
class PendingScreen extends StatefulWidget {
  final Map<String, dynamic> orderData;


  PendingScreen({Key? key,required this.orderData }) : super(key: key);

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
          .where('status', whereIn: ['pending','Ontheway', 'Arrived', 'processing', 'Confirm'])
          .where('acceptedBy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
          // Inside the StreamBuilder where you are fetching pending orders
List<DocumentSnapshot> pendingOrders = snapshot.data!.docs.where((order) {
  var orderId = order['ID'];
  return order['status'] == 'pending' && order['acceptedBy'] == FirebaseAuth.instance.currentUser!.uid;
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
                                  " ${orderData['status']}" + " ${DateFormat('dd/MM/yyyy').format(orderData['Date'].toDate())}",
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

}*/