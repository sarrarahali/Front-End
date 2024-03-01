class Commande{

  String nomprenom;
  String prix;
  int numeroId; 
DateTime date;
String  details ;
String localisation ;
String  KM;
String time;
String  Comment;
  Commande(this.prix, this.numeroId, this.nomprenom, this.date, this.details, this.localisation, this.KM, this.time, this.Comment);
}
List<String> dates = [
  
  "16/02/2024 ", "16/02/2024   ","14/02/2024 ","10/02/2024   ","11/02/2024  ","01/02/2024 "
  ];

  List<String> IDNP = [
    "nom et prenom ","nom non prenom ","nom et prenom ","nom et prenom ","nom et prenom ","nom et prenom ",
    
  ];
  List<String> PRIX = [
    "7 DT","4 DT","5 DT","7.5 DT "," 6 DT","10 DT",
    
  ];

 List<String> numid = [
    "7123","4999","5478","7221 ","1087","1234",
  ];
 List<String> details = [
    "Duo bucket x 1 items + coca cola",
    "coca cola",
    "qqqqqqqqq",
    "Duo bucket x 1 items + coca cola ",
    "Duo bucket x 1 items + coca cola",
    "Duo bucket x 1 items + coca cola",
  ];

  List<String> localisation= [
  "68 rue farhat hached sahloul - 4000 immeuble ElYoser étage 2" ,
  "70  sahloul - 4000 immeuble ElYoser étage 4",
  "68 rue farhat hached sahloul - 4000 immeuble ElYoser étage 2",
  "68 rue farhat hached sahloul - 4000 immeuble ElYoser étage 2",
  "68 rue farhat hached sahloul - 4000 immeuble ElYoser étage 2",
  "68 rue farhat hached sahloul - 4000 immeuble ElYoser étage 2",
  "68 rue farhat hached sahloul - 4000 immeuble ElYoser étage 2"
  ];
List<String> KM=[
"2.3KM" , "7KM", "5.3KM", "4.3KM", "9.3KM", "3KM"
];

List<String> time=[
"11:00" , "12:00", "10:30", "11:10", "09:30", "04:00", "13:00"
];
 

List<String> Comment=[
  "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam consetetur sadipsci", 

"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam consetetur sadipsci", 
"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam consetetur sadipsci", 
"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam consetetur sadipsci", 
"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam consetetur sadipsci",
 "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam consetetur sadipsci", "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam consetetur sadipsci"
];
 

  