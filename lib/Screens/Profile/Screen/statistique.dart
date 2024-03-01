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
      {"day 1": 80.0},
      {"day 2": 50.0},
      {"day 3": 30.0},
      {"day 4": 50.0},
      {"day 5": 10.0},
      {"day 6": 0.0},
      {"day 7": 100.0},
    ];

    // Define the Y axis values for the chart
    // String will be text label and double will be value in the Map<String, double>
    final List<Map<String, double>> yValues = [
      {"0": 0.0},
      {"20": 20.0},
      {"40": 40.0},
      {"60": 60.0},
      {"80": 80.0},
      {"100": 100.0},
    ];

    // Define the stroke width for the chart line
    final  stroke = 2.0;
    
      
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
      
    
     
  ],
)

              )
),






Card(
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
                          backgroundImage: AssetImage('images/trophy.png', ) ,
                        ),
                        SizedBox(height: 5.0),
                        Text('Lun'),
                      ],
                    ),

                     Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('images/trophy.png'),
                        ),
                        SizedBox(height: 5.0),
                        Text('Mard'),
                      ],
                    ),

                     Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('images/trophy.png'),
                        ),
                        SizedBox(height: 5.0),
                        Text('Merc'),
                      ],
                    ),

                     Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('images/trophy.png'),
                        ),
                        SizedBox(height: 5.0),
                        Text('Jeudi'),
                      ],
                    ),

                     
                     Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('images/trophy.png'),
                        ),
                        SizedBox(height: 5.0),
                        Text('Vend'),
                      ],
                    ),

                     Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('images/trophy.png'),
                        ),
                        SizedBox(height: 5.0),
                        Text('Sam'),
                      ],
                    ),

                     Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('images/trophy.png'),
                          
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