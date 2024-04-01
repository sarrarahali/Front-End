import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:boy/Screens/PendingScreen.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class CommandDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;
  final String source; // New parameter to determine the source

  final List<String> _list = [
    'pending',
    'on my why ',
    'arrived',
    'processing',
    'confirm',
  ];

  CommandDetailsPage({Key? key, required this.data, required this.source}) : super(key: key);
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: 
      Padding(
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
          SizedBox(height:50),
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
                          "# ${data['ID']}" + " ${data['NomPrenom'].toUpperCase()}",
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
                        SizedBox(width: 8),
                        Flexible(child:   Text("${data['Details']}", style: TextStyle(color: Colors.black, fontSize: 15)), )
                     
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
                        SizedBox(width: 8),
                        Flexible( // Use Flexible to allow wrapping
      child: Text(
        "${data['Localisation']}",
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
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

            // Display additional UI based on the source
            if (source == 'HomeScreen') ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomButton(
  title: "Accepter",
  onPressed: () {
    
  },
  color: GlobalColors.AcceptButton,
  borderRadius: 30,
  onTap: () {},
),


                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      title: "Refuser",
                      
                      onPressed: () {},
                      color: GlobalColors.RefuseButton,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
            
if (source == 'PendeingScreen') ...

       [
              CustomDropdown<String>(
                decoration: CustomDropdownDecoration(
                  closedBorder: Border.all(color: GlobalColors.mainColor),
                ),
                items: _list,
                initialItem: _list[0],
                onChanged: (value) {
                  debugPrint('changing value to: $value');
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
                        // Show dialog
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
                        
                      },
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