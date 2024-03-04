import 'package:boy/Screens/Profile/wid/fl.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class buildStatistiques extends StatefulWidget {
  const buildStatistiques({super.key});

  @override
  State<buildStatistiques> createState() => _buildStatistiquesState();
}

class _buildStatistiquesState extends State<buildStatistiques> {
    int _selectedIndex = 0;

    final List<Map<String, double>> xValues = [
      {"05 jan": 5},
      {"10 jan": 30},
      {"15 jan": 8},
      {"18 jan": 30},
     
     
     
    ];

    final List<Map<String, double>> yValues = [
     
      {"10": 10.0},
      {"20": 20.0},
      {"30": 30.0},
      {"40": 40.0},
      
    ];

    final  stroke = 3.5;
    
      
  @override
  Widget build(BuildContext context) {
    return 
    Column(
      children: [



Row(
  mainAxisAlignment: MainAxisAlignment.center ,
  children: [
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 0;
          });
        },
        style: ElevatedButton.styleFrom(

          foregroundColor: Colors.grey, backgroundColor: _selectedIndex == 0 ? GlobalColors.childmainColor : Colors.white, fixedSize: const Size(40, 10),
          shape: const StadiumBorder(),
        ),
        child: Text(
          "Jour",
          style: TextStyle(
            color: _selectedIndex == 0 ? GlobalColors.mainColor : Colors.grey,
          ),
        ),
      ),
    ),
    const SizedBox(width: 5),
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
        style: ElevatedButton.styleFrom(
        foregroundColor: Colors.grey, backgroundColor: _selectedIndex == 1 ? GlobalColors.childmainColor : Colors.white, fixedSize: const Size(30, 10),
          shape: const StadiumBorder(),
        ),
        child: Text(
          "Semaine",
          style: TextStyle(
            color: _selectedIndex == 1 ? GlobalColors.mainColor : Colors.grey,
          ),
        ),
      ),
    ),
    const SizedBox(width: 5),
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.grey, backgroundColor: _selectedIndex == 2 ? GlobalColors.childmainColor : Colors.white, fixedSize: const Size(50, 10),
          shape: const StadiumBorder(),
        ),
        child: Text(
          "Mois",
          style: TextStyle(
            color: _selectedIndex == 2 ? GlobalColors.mainColor : Colors.grey,
          ),
        ),
      ),
    ),
    const SizedBox(width: 5),
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 3;
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.grey, backgroundColor: _selectedIndex == 3 ? GlobalColors.childmainColor : Colors.white, fixedSize: const Size(50, 10),
          shape: const StadiumBorder(),
        ),
        child: Text(
          "Ans",
          style: TextStyle(
            color: _selectedIndex == 3 ? GlobalColors.mainColor  : Colors.grey,
          ),
        ),
      ),
    ),
  ],

),
const SizedBox(height: 30,),
Card(
   color: Colors.white,
  elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(20),
                child:Column(
                      children: [ 
                             Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                 const Text("Rendement ", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                               IconButton(
                                onPressed: () {},
                                 icon: Image.asset("images/calendar.png",) ),

 ],
      ),
     
 SizedBox(height:30),  
 Align(
  alignment: Alignment.topLeft ,
   child:Text("commande", style: TextStyle(fontSize: 15, color: Colors.grey,
           ),),
 ),
Align(
  alignment: Alignment.topLeft,  
 child: Icon(Icons.circle , size: 10, color: Colors.amber,)
 ),
    CustomPaint(
                  painter: CurvedChartPainter(
                    xValues: xValues,
                    yValues: yValues,
                    strokeWidth: stroke,
                   
                  ),
                   
                  size: Size(250, 150),
                ),
     SizedBox(height:40)
  ],
)

              )
),


Card(
  color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Les Derniers 7 Jours',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                     Column(
                      children: [
                        CircleAvatar(
                               radius: 20,
                               backgroundColor: GlobalColors.trophy,
                                child: ClipOval(
                                child: Image.asset('images/trophy.png',
                               width: 40, 
                             height: 40, 
        
                                               ),
                                      ),
                             ),
                        SizedBox(height: 5.0),
                        Text('Lun'),
                      ],
                    ),

                     Column(
                      children: [
                             CircleAvatar(
                               radius: 20,
                               backgroundColor: GlobalColors.trophy,
                                child: ClipOval(
                                child: Image.asset('images/trophy.png',
                               width: 40, 
                             height: 40, 
        
                                               ),
                                      ),
                             ),
                        SizedBox(height: 5.0),
                        Text('Mard'),
                      ],
                    ),


                     Column(
                      children: [
                                 CircleAvatar(
                               radius: 20,
                               backgroundColor: GlobalColors.trophy,
                                child: ClipOval(
                                child: Image.asset('images/trophy.png',
                               width: 40, 
                             height: 40, 
        
                                               ),
                                      ),
                             ),
                        SizedBox(height: 5.0),
                        Text('Merc'),
                      ],
                    ),

                     Column(
                      children: [
                       CircleAvatar(
                               radius: 20,
                               backgroundColor: GlobalColors.trophy,
                                child: ClipOval(
                                child: Image.asset('images/trophy.png',
                               width: 40, 
                             height: 40, 
                                               ),
                                      ),
                             ),
                        SizedBox(height: 5.0),
                        Text('Jeudi'),
                      ],
                    ),

                     
                     Column(
                      children: [
                        CircleAvatar(
                               radius: 20,
                               backgroundColor: GlobalColors.trophy,
                                child: ClipOval(
                                child: Image.asset('images/trophy.png',
                               width: 40, 
                             height: 40, 
        
                                               ),
                                      ),
                             ),
                        SizedBox(height: 5.0),
                        Text('Vend'),
                      ],
                    ),

                     Column(
                      children: [
                       CircleAvatar(
                               radius: 20,
                               backgroundColor: GlobalColors.trophy,
                                child: ClipOval(
                                child: Image.asset('images/trophy.png',
                               width: 40, 
                             height: 40, 
        
                                               ),
                                      ),
                             ),
                        SizedBox(height: 5.0),
                        Text('Sam'),
                      ],
                    ),

                     Column(
                      children: [
                        CircleAvatar(
                               radius: 20,
                               backgroundColor: GlobalColors.trophy,
                                child: ClipOval(
                                child: Image.asset('images/trophy.png',
                               width: 40, 
                             height: 40, 
                                               ),
                                      ),
                             ),
                        SizedBox(height: 5.0),
                        Text('Dim'),
                      ],
                    ),


                  ],
                ),
              ],
            ),
          ),
        ),




      ],
    
    );





  }
}