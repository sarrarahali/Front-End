import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class OrderCard extends StatelessWidget {
  final Map<String, dynamic> orderData;
  final bool isCancelled;

  const OrderCard({Key? key, required this.orderData, required this.isCancelled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
 // Convert timestamp to DateTime
    DateTime? dateCancelled = orderData['DateCancelled']?.toDate();
    DateTime? dateDelivered = orderData['DateDelivered']?.toDate();
    return Card(
          elevation: 2,
          
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (isCancelled && dateCancelled != null)
              Text('${DateFormat('yyyy-MM-dd HH:mm:ss').format(dateCancelled)}'),
            if (!isCancelled && dateDelivered != null)
              Text(' ${DateFormat('yyyy-MM-dd HH:mm:ss').format(dateDelivered)}'),
                        SizedBox(height: 5.0),
                        Row(
                          children: <Widget>[
                            Image.asset(
                          isCancelled ? 'images/dismiss-task.png' : 'images/active-task.png',
                          width: 14,
                          height: 14,
                        ),
                            SizedBox(width: 5.0),
                             Text(' ${isCancelled ? 'Cancelled' : 'Delivered'}'),
            SizedBox(height: 8),
           
                          ],
                        ),
                      ],
                    ),
                   
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "NUMÉRO ID",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5.0),
                         Text(
              '${orderData['ID']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );


    
    
    
  }}




class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('CancelledOrders').where('UserID', isEqualTo: userId).snapshots(),
              builder: (context, canceledSnapshot) {
                if (canceledSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (canceledSnapshot.hasError) {
                  return Text('Error: ${canceledSnapshot.error}');
                }
                final canceledOrders = canceledSnapshot.data?.docs ?? [];

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('DeliveredOrders').where('UserID', isEqualTo: userId).snapshots(),
                  builder: (context, deliveredSnapshot) {
                    if (deliveredSnapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (deliveredSnapshot.hasError) {
                      return Text('Error: ${deliveredSnapshot.error}');
                    }
                    final deliveredOrders = deliveredSnapshot.data?.docs ?? [];
// Combine and sort the orders by their cancellation or delivery date
final allOrders = [...canceledOrders, ...deliveredOrders];
allOrders.sort((a, b) {
  final aData = a.data() as Map<String, dynamic>;
  final bData = b.data() as Map<String, dynamic>;
  final aDate = aData['DateCancelled'] ?? aData['DateDelivered'];
  final bDate = bData['DateCancelled'] ?? bData['DateDelivered'];

  if (aDate == null && bDate == null) {
    return 0; // Both dates are null, consider them equal
  } else if (aDate == null) {
    return 1; // Only aDate is null, consider it greater than bDate
  } else if (bDate == null) {
    return -1; // Only bDate is null, consider it less than aDate
  } else {
    return (bDate as Timestamp).compareTo(aDate as Timestamp); // Sorting in descending order
  }
});

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        
                        ),
                        ...allOrders.map((order) {
                          final orderData = order.data() as Map<String, dynamic>;
                          final isCancelled = orderData.containsKey('DateCancelled');
                          return OrderCard(orderData: orderData, isCancelled: isCancelled);
                        }),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}






