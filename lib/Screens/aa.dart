
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:boy/Screens/PendingScreen.dart';
import 'package:boy/Screens/map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:intl/intl.dart'; // Import the intl package

class CommandDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;
  final String documentId;
  final String source;

  const CommandDetailsPage({
    Key? key,
    required this.data,
    required this.documentId,
    required this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Delivered'; // Default value
    String popupPhrase = 'Place the order to delivery'; // Default phrase

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "ORDER DETAILS",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    // Phone call icon
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: GlobalColors.childmainColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: "${data['Phone']}",
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              print('cannot launch this url');
                            }
                          },
                          color: GlobalColors.childmainColor,
                          icon: Image.asset(
                            "images/phone.png",
                            color: GlobalColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                    // Pin location icon
                    Container(
                      decoration: BoxDecoration(
                        color: GlobalColors.childmainColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(
                                commandes: FirebaseFirestore.instance.collection('commandes '),
                                specificOrderLocation: data['Localisation'],
                                fromHomepage: source == 'HomeScreen',
                                showPolyline: source == 'PendingScreen',
                                source: source, // Pass the source information
                              ),
                            ),
                          );
                        },
                        icon: Image.asset("images/pin-icon.png"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Order details card
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order ID and Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "# ${data['ID']} ${data['NomPrenom']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            "à la livraison",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      // Order details
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
                              "${data['Details']}",
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Location
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: GlobalColors.localisationbg,
                            ),
                            child: Icon(Ionicons.location_outline, color: GlobalColors.localisation),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              "${data['Localisation']}",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Price, Time, and Distance
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset("images/tag.png"),
                          SizedBox(width: 3),
                          Text(
                            "${data['Prix']} DT",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(width: 30),
                          Image.asset("images/time-icon.png"),
                          SizedBox(width: 3),
                          Text(
                            DateFormat.Hm().format(data['Date'].toDate()),
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(width: 30),
                          Image.asset("images/map-location.png"),
                          SizedBox(width: 3),
                          Text(
                            "${data['Km']}km",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Comment card
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Comment",
                        style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // Check if comment is null
                      data['Comment'] != null
                          ? Text(
                              "${data['Comment']}",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.black, fontSize: 17),
                            )
                          : Text(
                              "Aucun commentaire pour cette commande",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.black, fontSize: 17),
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Display buttons based on source
              if (source == 'HomeScreen') ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomButton(
                              title: "Accepter",
                              onPressed: () async {
                                // Get current user's ID
                                String userId = FirebaseAuth.instance.currentUser!.uid;

                                // Update the 'acceptedByUserId' field in Firestore
                                DocumentReference orderRef =
                                    FirebaseFirestore.instance.collection('commandes ').doc(documentId);
                                await orderRef.update({
                                  'acceptedByUserId': userId,
                                });

                                // Show a message or update the UI accordingly
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text('Order accepted')));
                                    await Future.delayed(
                                              Duration(seconds: 2));

                                          Navigator.pop(context);
                              },
                              color: GlobalColors.AcceptButton,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: CustomButton(
                              title: "Refuser",
                              onPressed: () async {
                                // Get current user's ID
                                String userId = FirebaseAuth.instance.currentUser!.uid;

                                // Update the 'refusedBy' field in Firestore
                                DocumentReference orderRef =
                                    FirebaseFirestore.instance.collection('commandes').doc(documentId);
                                await orderRef.update({
                                  'refusedBy': FieldValue.arrayUnion([userId])
                                });

                                // Show a message or update the UI accordingly
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text('Order refused')));
                                    await Future.delayed(
                                              Duration(seconds: 2));

                                          Navigator.pop(context);
                              },
                              color: GlobalColors.RefuseButton,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              if (source == 'PendingScreen') ...[
                CustomDropdown<String>(
                  decoration: CustomDropdownDecoration(
                    closedBorder: Border.all(color: GlobalColors.mainColor),
                  ),
                  items: ['cancelled', 'Delivered'],
                  initialItem: 'Delivered',
                  onChanged: (value) {
                    dropdownValue = value!; // Update dropdownValue
                    if (value == 'cancelled') {
                      popupPhrase = 'Cancel the order please';
                    } else {
                      popupPhrase = 'Place the order to delivery';
                    }
                    debugPrint('changing value to: $value');
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        title: "Register",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              Size screenSize = MediaQuery.of(context).size;
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                contentPadding: EdgeInsets.all(10),
                                content: Container(
                                  width: screenSize.width * 0.9,
                                  height: screenSize.height * 0.3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(Icons.close),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        popupPhrase,
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Are you sure about this step?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      SizedBox(height: 40),
                                      CustomButton(
                                        title: "Register",
                                        onPressed: () async {
                                          if (dropdownValue == 'cancelled') {
                                            String userId = FirebaseAuth.instance.currentUser!.uid;
await FirebaseFirestore.instance.collection('CancelledOrders').doc(userId).set({
  'ID': data['ID'],
   'UserID': userId, // Storing the user's ID
  'NomPrenom': data['NomPrenom'],
  'DateCancelled': Timestamp.now(),
});

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'The order has been canceled successfully.'),
                                              duration: Duration(seconds: 2),
                                            ));
                                          } else {
                                            String userId = FirebaseAuth.instance.currentUser!.uid;
await FirebaseFirestore.instance.collection('DeliveredOrders').doc(userId).set({
  'ID': data['ID'],
   'UserID': userId, // Storing the user's ID
  'NomPrenom': data['NomPrenom'],
  'DateDelivered': Timestamp.now(),
});
                                           

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'The order has been delivered successfully.'),
                                              duration: Duration(seconds: 2),
                                            ));
                                          }

                                          await Future.delayed(
                                              Duration(seconds: 2));

                                          Navigator.pop(context);
                                        },
                                        color: GlobalColors.AcceptButton,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        color: GlobalColors.AcceptButton,
                        borderRadius: 30,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        title: "Close",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: GlobalColors.RefuseButton,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}



