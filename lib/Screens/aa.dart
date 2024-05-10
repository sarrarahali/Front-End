import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:boy/Screens/PendingScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boy/Screens/map.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';

class CommandDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;
  final Function(String) acceptCommand;
   final Function(String) refuseCommand; // Add this callback
  final String documentId;
  final String source;

  const CommandDetailsPage({
    Key? key,
    required this.data,
    required this.acceptCommand,
    required this.refuseCommand,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
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
                          scheme:'tel',
                         path:"${data['Phone']}",
                        );
                        if(await canLaunchUrl(url)){
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
                    onPressed: () {},
                    icon: Image.asset("images/pin-icon.png"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Order details card
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Order ID and Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "# ${data['ID']}" + " ${data['NomPrenom']}",
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
                        Flexible(child: Text("${data['Details']}", style: TextStyle(color: Colors.black, fontSize: 15))),
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
                        SizedBox(width: 5),
                        Text(
                          "${data['Prix']} DT",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(width: 60),
                        Image.asset("images/time-icon.png"),
                        SizedBox(width: 5),
                        Text(
                          "${data['time']}",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(width: 60),
                        Image.asset("images/map-location.png"),
                        SizedBox(width: 5),
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
                    Text(
                      " ${data['Comment']}",
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
                    flex: 2,
                    child:CustomButton(
                      title: "Accepter",
                   onPressed: () {
  acceptCommand(documentId); // Only accept the command without changing its status
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PendingScreen(acceptCommand: acceptCommand, refuseCommand: refuseCommand,),
    ),
  );
},

  
                      color: GlobalColors.AcceptButton,
                      onTap: () {},
                    ),
                    
              

                  ),
      
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      title: "Refuser",
                      onPressed: () {
                refuseCommand(documentId); // Call the callback with the documentId
                Navigator.pop(context); // Close the details page
              },
                      color: GlobalColors.RefuseButton,
                      onTap: () {},
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
               items: ['canclled', 'Delivred'],
                initialItem: 'Delivred',
              onChanged: (value) {
  dropdownValue = value; // Update dropdownValue
  if (value == 'canclled') {
    popupPhrase = 'Cancel the order please';
  } else {
    popupPhrase = 'Place the order to delivery';
  }
  debugPrint('changing value to: $value');
},


              ),
           
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
    // Get the size of the screen
    Size screenSize = MediaQuery.of(context).size;
    return AlertDialog(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0), // Adjust the border radius as needed
    ),
      contentPadding: EdgeInsets.all(10), // Remove padding
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
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Icon(Icons.close), // Close icon
              ),
            ),
            SizedBox(height: 8), // Adjust the space between the close icon and content
            Text(
  popupPhrase,
  style: TextStyle(fontSize: 16),
  textAlign: TextAlign.center,
),

           SizedBox(height: 8), // Adjust the space between the title and content
            Text(
              "Are you sure about this step?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
            // Adjust the space between the content and button
             SizedBox(height: 40),
         
                CustomButton(
                  title: "Register",
                 onPressed: () async {
                        // Determine if the order is being canceled or delivered
                        if (dropdownValue == 'canclled') {
                          // Save order information to CancelledOrders collection
                          await FirebaseFirestore.instance.collection('CancelledOrders').doc(documentId).set({
                            'ID': data['ID'],
                            'NomPrenom': data['NomPrenom'],
                            'DateCancelled': Timestamp.now(), // Current date and time
                          });

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('The order has been canceled successfully.'),
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          // Save order information to DeliveredOrders collection
await FirebaseFirestore.instance.collection('DeliveredOrders').doc(documentId).set({
  'ID': data['ID'],
  'NomPrenom': data['NomPrenom'],
  'DateDelivered': Timestamp.now(), // Current date and time
});

// Show success message if the context is still valid
if (Navigator.canPop(context)) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('The order has been delivered successfully.'),
    duration: Duration(seconds: 2),
  ));
}

                          
                          
                                      
                                      }
                                       // Use another delay before navigating back to the pending screen
    await Future.delayed(Duration(seconds: 2)); // Adjust delay duration as needed

    // Navigate back to the pending screen
    Navigator.pop(context);

                     
                                    },
                                    
                                    color: GlobalColors.AcceptButton,
                                    onTap: () {},
                                    
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
                      onTap: () {},
                    ),
                  

                  
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      title: "Close",
                                onPressed: () {
            Navigator.pop(context); // Navigate back to the pending screen
          },

                      //onPressed: () {},
                      color: GlobalColors.RefuseButton,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}


/*import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CommandDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const CommandDetailsPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Command Details"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                           "# ${data['ID']}"+" ${data['NomPrenom']}",
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
                        SizedBox(width: 5),
                        Text("${data['Details']}", style: TextStyle(color: Colors.black, fontSize: 15)),
                      ],
                    ),
                    SizedBox(height: 20),
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
                        SizedBox(width: 5),
                        Text(
                        " ${data['Localisation']}",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("images/tag.png"),
                        SizedBox(width: 5),
                        Text(
                         "${data['Prix']} DT",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(width: 90),
                        Image.asset("images/time-icon.png"),
                        SizedBox(width: 5),
                        Text(
                        "${data['time']}",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(width: 50),
                        Image.asset("images/map-location.png"),
                        SizedBox(width: 5),
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
                    Text(
                      " ${data['Comment']}",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ],
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