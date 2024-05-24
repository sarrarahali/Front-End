
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ionicons/ionicons.dart';
import 'package:boy/Widgets/Colors.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ionicons/ionicons.dart';
import 'package:boy/Widgets/Colors.dart';
class OnTheWayOrdersScreen extends StatefulWidget {
  final String acceptedByUserId;

  OnTheWayOrdersScreen({required this.acceptedByUserId});

  @override
  _OnTheWayOrdersScreenState createState() => _OnTheWayOrdersScreenState();
}

class _OnTheWayOrdersScreenState extends State<OnTheWayOrdersScreen> {
  late List<Map<String, dynamic>> orders;

  @override
  void initState() {
    super.initState();
    orders = [];

    // Fetch initial orders
    _fetchOrders();
  }

  void _fetchOrders() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('commandes ')
        .where('acceptedByUserId', isEqualTo: widget.acceptedByUserId)
        .get();
    setState(() {
      orders = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTIFICATIONS' ),
       // automaticallyImplyLeading: false,
centerTitle: true ,
      ),
      body: ListView(
        children: [
          for (var orderData in orders)
            _buildOrderCards(orderData),
        ],
      ),
    );
  }

  Widget _buildOrderCards(Map<String, dynamic> orderData) {
    List<Widget> cards = [];

    // Add the original card for pending orders
    cards.add(_buildOrderCard(orderData, "Commande en attente", "nous vous informe que vous avez une commande en attente de traitement ${orderData['ID']}", "images/order.png"));

    // Add a new card if status is on the way
    if (orderData['status'] == 'Ontheway') {
      cards.add(_buildOrderCard(orderData, "Une commande en cours",  "nous vous informe que vous avez une commandeest en cours de livraison ${orderData['ID']}", "images/order2.png",));
    
      
    }

    return Column(
      children: cards,
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> orderData, String title, String subtitle,String imagePath  )  {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          leading: Container(
  width: 50,
  height: 50,
  decoration: BoxDecoration(
    color: GlobalColors.childmainColor,
    borderRadius: BorderRadius.circular(8), 
   
  ),
  child: Image.asset(
    imagePath,
  ),
),

          title: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: 
          
          Text(
            subtitle,
           
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Ionicons.time_outline,
                size: 14,
              ),
              const SizedBox(width: 5),
              Text(
                "${DateFormat.Hm().format(orderData['Date'].toDate())}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}






