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

Column(
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




      ],
    
    );





  }
}

