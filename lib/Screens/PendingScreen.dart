
import 'package:boy/Screens/NotificationSceen.dart';
import 'package:boy/Screens/aa.dart';
import 'package:boy/Widgets/Easystepper.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:get/get.dart';

import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';
/*
import '../notification_helper.dart';

class PendingScreen extends StatefulWidget {
  final Map<String, dynamic> orderData;

  PendingScreen({Key? key, required this.orderData}) : super(key: key);

  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  late List<String> canceledOrderIds;
  late List<String> deliveredOrderIds;
 List<Map<String, dynamic>> notifications = [];  // List to store notifications

  @override
  void initState() {
    super.initState();
    canceledOrderIds = [];
    deliveredOrderIds = [];

    FirebaseFirestore.instance
        .collection('CancelledOrders')
        .get()
        .then((querySnapshot) {
      setState(() {
        canceledOrderIds =
            querySnapshot.docs.map((doc) => doc['ID'].toString()).toList();
      });
    });

    FirebaseFirestore.instance
        .collection('DeliveredOrders')
        .get()
        .then((querySnapshot) {
      setState(() {
        deliveredOrderIds =
            querySnapshot.docs.map((doc) => doc['ID'].toString()).toList();
      });
    });
  }


void _onStatusChanged(String newStatus, Map<String, dynamic> orderData) {
    if (newStatus == 'on the way') {
      setState(() {
        notifications.add({
          'message': 'Commande en cours',
          'time': DateTime.now(),
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('commandes ')
            .where('acceptedByUserId',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            print('No pending orders for the current user.');
            return Center(child: Text('No pending orders'));
          } else {
            var pendingOrders = snapshot.data!.docs
                .where((order) {
                  var orderData = order.data() as Map<String, dynamic>;
                  return orderData['acceptedByUserId'] ==
                      FirebaseAuth.instance.currentUser!.uid;
                })
                .toList();

            int orderCount = pendingOrders.length;

            print('Found $orderCount pending orders for the current user.');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "# ${orderData['ID']} " +
                                        "${orderData['NomPrenom']} ",
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    " ${orderData['status']}" +
                                        " ${DateFormat('dd/MM/yyyy').format(orderData['Date'].toDate())}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CommandDetailsPage(
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
                            easy_stepper (
                              onStatusChanged: (status) {
                                String newStatus =
                                    status.toString().split('.').last;
                                order.reference.update({'status': newStatus});
                                _onStatusChanged(newStatus, orderData);
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
*/




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

  PendingScreen({Key? key, required this.orderData}) : super(key: key);

  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  late List<String> canceledOrderIds;
  late List<String> deliveredOrderIds;
  late Stream<QuerySnapshot> onTheWayOrdersStream;
 late Stream<QuerySnapshot> pendingOrdersStream;

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

    // Initialize onTheWayOrdersStream
    onTheWayOrdersStream = FirebaseFirestore.instance
        .collection('commandes ')
        .where('status', isEqualTo: 'Ontheway')
        .snapshots();
        // Initialize onTheWayOrdersStream
    pendingOrdersStream = FirebaseFirestore.instance
        .collection('commandes ')
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Orders'),
       
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('commandes ')
           
            .where('acceptedByUserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No pending orders'));
          } else {
            var pendingOrders = snapshot.data!.docs.where((order) {
              var orderData = order.data() as Map<String, dynamic>;
              return
                  orderData['acceptedByUserId'] == FirebaseAuth.instance.currentUser!.uid;
            }).toList();

            int orderCount = pendingOrders.length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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

if (newStatus == 'Ontheway') {
                                 return Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const Notificationscreen()),
                                      );
                               
                                }
  Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromARGB(255, 214, 249, 215),
                            ),
                            child: Icon(Icons.check, color: GlobalColors.stepper),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'nous vous informe que vous avez une commande en attende',
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
              );
              */







/*

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:boy/Screens/aa.dart';
import 'package:boy/Widgets/Easystepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';

class PendingScreen extends StatefulWidget {
  final Map<String, dynamic> orderData;

  PendingScreen({Key? key, required this.orderData}) : super(key: key);

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
print('pushnotification');
    FirebaseFirestore.instance
        .collection('CancelledOrders')
        .get()
        .then((querySnapshot) {
      setState(() {
        canceledOrderIds =
            querySnapshot.docs.map((doc) => doc['ID'].toString()).toList();
      });
    });

    FirebaseFirestore.instance
        .collection('DeliveredOrders')
        .get()
        .then((querySnapshot) {
      setState(() {
        deliveredOrderIds =
            querySnapshot.docs.map((doc) => doc['ID'].toString()).toList();
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
            .where('acceptedByUserId',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            print('No pending orders for the current user.');
            return Center(child: Text('No pending orders'));
          } else {
            var pendingOrders = snapshot.data!.docs
                .where((order) {
                  var orderData = order.data() as Map<String, dynamic>;
                  return orderData['acceptedByUserId'] ==
                      FirebaseAuth.instance.currentUser!.uid;
                })
                .toList();

            int orderCount = pendingOrders.length;

            print('Found $orderCount pending orders for the current user.');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "# ${orderData['ID']} " +
                                        "${orderData['NomPrenom']} ",
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    " ${orderData['status']}" +
                                        " ${DateFormat('dd/MM/yyyy').format(orderData['Date'].toDate())}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CommandDetailsPage(
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
                          
                          easy_stepper (
                              onStatusChanged: (status) {
                                String newStatus =
                                    status.toString().split('.').last;
                                order.reference
                                    .update({'status': newStatus});
                                if (newStatus == 'ontheway') {
                                  NotificationHelper.pushNotification(
                                      title: 'commande en attende',
                                      body:
                                          'nous vous informe que vous avez une livraison dans...');
                                }
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
*/