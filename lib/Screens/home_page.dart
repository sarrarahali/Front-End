
import 'package:boy/Screens/OrderDetailScreen.dart';
import 'package:boy/Screens/traking_screen.dart';
import 'package:boy/model/commande_model.dart';
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
             child:IconButton(
  onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> trakingscreen()
      ),   
      );
     },
  icon: Image.asset("images/pin-icon.png"),
),

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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
    builder: (context) => OrderDetailsScreen(
      index: index,
      commande: Commande(
        PRIX[index],
        int.parse(numid[index]),
        IDNP[index],
        DateTime.now(),
        details[index],
        localisation[index],
        KM[index],
        time[index],
        Comment[index],
      ),
      source: 'HomeScreen', // Pass the source parameter
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

  
 

