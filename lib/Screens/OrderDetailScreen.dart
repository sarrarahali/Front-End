import 'package:flutter/material.dart';
import 'package:boy/model/commande_model.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:ionicons/ionicons.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart'; // Corrected import statement

class OrderDetailsScreen extends StatefulWidget {
  final int index;
  final Commande commande;
  final String source;

  const OrderDetailsScreen({
    Key? key,
    required this.index,
    required this.commande,
    required this.source,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
   

  final List<String> _list = [
    'pending',
    'on my why ',
    'arrived',
    'processing',
    'confirm',
  ];

  @override
  Widget build(BuildContext context) {
    Commande commande = widget.commande;

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
                  child: Text(
                    "ORDER DETAILS",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: GlobalColors.childmainColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      color: GlobalColors.childmainColor,
                      icon: Image.asset(
                        "images/phone.png",
                        color: GlobalColors.mainColor,
                      ),
                    ),
                  ),
                ),
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
            SizedBox(height: 50),
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
                          commande.nomprenom,
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
                        Text(commande.details, style: TextStyle(color: Colors.black, fontSize: 15)),
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
                          commande.localisation,
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
                          commande.prix,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(width: 90),
                        Image.asset("images/time-icon.png"),
                        SizedBox(width: 5),
                        Text(
                          commande.time,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(width: 70),
                        Image.asset("images/map-location.png"),
                        SizedBox(width: 5),
                        Text(
                          commande.KM,
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
                      commande.Comment,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.source == 'PendeingScreen') ...[
              CustomDropdown<String>(
               decoration: CustomDropdownDecoration(
                closedBorder: Border.all(color: GlobalColors.mainColor)
               ),
                items: _list,
                initialItem: _list[0],
                onChanged: (value) {
                  debugPrint('changing value to: $value', );
                },
              ),
              SizedBox(height: 10),
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
              'Place the order to delivery',
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
                  onPressed: () {},
                  color: GlobalColors.AcceptButton,
                 // onTap: () {},
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
                      //onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      title: "Close",
                      onPressed: () {},
                      color: GlobalColors.RefuseButton,
                     // onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
            if (widget.source == 'HomeScreen') ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      title: "Accepter",
                      onPressed: () {},
                      color: GlobalColors.AcceptButton,
                      borderRadius: 30,
                     // onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      title: "Refuser",
                      onPressed: () {},
                      color: GlobalColors.RefuseButton,
                    //  onTap: () {},
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
