import 'package:flutter/material.dart';

class BuildHistorique extends StatefulWidget {
  const BuildHistorique({Key? key}) : super(key: key);

  @override
  State<BuildHistorique> createState() => _BuildHistoriqueState();
}

class _BuildHistoriqueState extends State<BuildHistorique> {
  List<String> dates = [
    "16/02/2024   14:00", "16/02/2024   15:00", "14/02/2024   12:30",
    "10/02/2024   5:10", "11/02/2024   10:01", "01/02/2024 17:10"
  ];

  List<String> statuses = ["annuler", "complété", "annuler", "complété", "annuler", "complété"];

  List<String> numid = [
    "12345", "12775", "88345", "09345", "13345", "11145", "9995"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
       physics: BouncingScrollPhysics(),
                shrinkWrap: true,
      itemCount: dates.length,
      itemBuilder: (BuildContext context, int index) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          elevation: 2,
          
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dates[index],
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              statuses[index] == "annuler"
                                  ? 'images/dismiss-task.png'
                                  : 'images/active-task.png',
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              statuses[index],
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                   
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "NUMÉRO ID",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          numid[index],
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
    );
  }
}
