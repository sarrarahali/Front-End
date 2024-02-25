import 'package:boy/Screens/OrderDetailsScreen2.dart';
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


   List<String> dates = ["16/02/2024 ", "16/02/2024   15:00","14/02/2024   12:30","10/02/2024   5:10"
  ];

  List<String> IDNP = [
    "nom et prenom ","nom et prenom ","nom et prenom ","nom et prenom ","nom et prenom ",
    
  ];
  List<String> PRIX = [
    "7 DT","4 DT","5 DT","7.5 DT "," 6 DT"
  ];

 List<String> numid = [
    "7123","4999","5478","7221 ","1087","1234",
    
  ];
  static List<Commandemodel> mainCommandeList = [];
  List<Commandemodel> displayList = List.from(mainCommandeList);
  
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
            crossAxisAlignment: CrossAxisAlignment.start, // Add this line
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
                      GestureDetector(
                        onTap: () {
                          // Navigate to Order Details page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>const OrderDetailsScreen2()),
                          );
                        },
                        child: Icon(
                          Ionicons.chevron_forward_outline,
                          color: GlobalColors.iconColor,
                        ),
                      )
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







 
  
 

