import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('CancelledOrders').snapshots(),
              builder: (context, canceledSnapshot) {
                if (canceledSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (canceledSnapshot.hasError) {
                  return Text('Error: ${canceledSnapshot.error}');
                }
                final canceledOrders = canceledSnapshot.data?.docs ?? [];

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('DeliveredOrders').snapshots(),
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

/*
class BuildHistorique extends StatefulWidget {
  const BuildHistorique({Key? key}) : super(key: key);

  @override
  State<BuildHistorique> createState() => _BuildHistoriqueState();
}

class _BuildHistoriqueState extends State<BuildHistorique> {
  List<String> dates = [
    "16/02/2024   14:00", "16/02/2024   15:00", "14/02/2024   12:30",
    "10/02/2024   5:10", "11/02/2024   10:01", "01/02/2024 17:10"
  ];

  List<String> statuses = ["annuler", "complété", "annuler", "complété", "annuler", "complété"];

  List<String> numid = [
    "12345", "12775", "88345", "09345", "13345", "11145", "9995"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
       physics: BouncingScrollPhysics(),
                shrinkWrap: true,
      itemCount: dates.length,
      itemBuilder: (BuildContext context, int index) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
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
                        Text(
                          dates[index],
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              statuses[index] == "annuler"
                                  ? 'images/dismiss-task.png'
                                  : 'images/active-task.png',
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              statuses[index],
                              style: TextStyle(color: Colors.black),
                            ),
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
                          numid[index],
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
