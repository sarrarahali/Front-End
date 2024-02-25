import 'package:boy/Screens/Profile/Screen/HistoriqueScreen.dart';
import 'package:boy/Screens/Profile/Screen/InformationScreen.dart';
import 'package:boy/Screens/Profile/Screen/StatistiqueScreen.dart';
import 'package:boy/Widgets/Colors.dart';

import 'package:flutter/material.dart';






class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
 
  int _selectedIndex = 0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColorbg,
      body: Stack(
        children: [
          Container(
            child: const Padding(
              padding: EdgeInsets.only(top: 80, left: 40),
              child: Text(
                'BONJOUR MED !',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedIndex = 0;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.grey, backgroundColor: _selectedIndex == 0
                                    ? GlobalColors.mainColor
                                    : Colors.white, shape: const StadiumBorder(),
                              ),
                              child: Text(
                                "Information",
                                style: TextStyle(
                                  color: _selectedIndex == 0
                                      ? Colors.white
                                      : Colors.grey,
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
                                foregroundColor: Colors.grey, backgroundColor: _selectedIndex == 1
                                    ? GlobalColors.mainColor
                                    : Colors.white, shape: const StadiumBorder(),
                              ),
                              child: Text(
                                "Historique",
                                style: TextStyle(
                                  color: _selectedIndex == 1
                                      ? Colors.white
                                      : Colors.grey,
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
                                foregroundColor: Colors.grey, backgroundColor: _selectedIndex == 2
                                    ? Colors.deepPurple
                                    : Colors.white, shape: const StadiumBorder(),
                              ),
                              child: Text(
                                "Statistiques",
                                style: TextStyle(
                                  color: _selectedIndex == 2
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100000, 
                        child: IndexedStack(
                          index: _selectedIndex,
                          children: const [
                            buildInformation(),
                            BuildHistorique(),
                           
                            buildStatistiques(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}