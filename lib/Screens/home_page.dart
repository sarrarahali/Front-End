
import 'package:boy/Screens/OrderDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/search.dart';

import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 List<String> dates = ["16/02/2024 ", "16/02/2024   15:00","14/02/2024   12:30","10/02/2024   5:10","11/02/2024   10:01","01/02/2024 17:10"
  ];

  List<String> IDNP = [
    "nom et prenom ","nom et prenom ","nom et prenom ","nom et prenom ","nom et prenom ","nom et prenom ",
    "nom et prenom "
  ];
  List<String> PRIX = [
    "7 DT","4 DT","5 DT","7.5 DT "," 6 DT","10 DT",
    "10.5 DT "
  ];

 List<String> numid = [
    "7123","4999","5478","7221 ","1087","1234",
    "1044"
  ];
  

  void updateList(String value) {}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:   CrossAxisAlignment.start,
          children: [
            
           Row(
             children: [
               Expanded(
                child: SearchWidget()),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal:10 ),
             child: Container(
               decoration: BoxDecoration(
                 color: GlobalColors.mainColor,
                 borderRadius: BorderRadius.circular(8),
               ),
               child: IconButton(
                 
                 onPressed: () {},
                 color: GlobalColors.mainColor,
                                   icon: Image.asset("images/liste_icon.png",
)             
                 
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
                                 icon: Image.asset("images/pin-icon.png",
)             ),

           ),

             ],
           ),
            SizedBox(height: 20,),
            Text("NEW ORDER ", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),),
            SizedBox(height: 8),
RichText(
  text: TextSpan(
    style: DefaultTextStyle.of(context).style,
    children: const <TextSpan>[
      TextSpan(text: '40 Nouveaux ', style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: 'commandes sont disponibles'),
    ],
  ),
),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
 children: [
  Expanded(child: Text("Tous les commandes ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
  ),  
  
   IconButton(
               onPressed: () {},
                                 icon: Image.asset("images/filtre.png",
) ),
//  ),
 ],
),
         Expanded(
  child: ListView.builder(
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: dates.length,
    itemBuilder: (BuildContext context, int index) => Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '#${numid[index]} ${IDNP[index]}',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                SizedBox(width: 110,),
                  Text(
                    '${PRIX[index]}',
                    style: TextStyle(color: GlobalColors.mainColorbg, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Pending ${dates[index]}',
                    style: TextStyle(color: Colors.black),
                  ),
                  Row(
                    children: [
                      Text(
                        "à la livraison",
                        style: TextStyle(color: Colors.black),
                      ),
                     IconButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(index: index),
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
                ],
              ),
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

  
 

