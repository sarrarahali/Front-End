import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final CollectionReference _commandes =
      FirebaseFirestore.instance.collection('commande');

  Stream<List<Commande>> get commandes {
    return _commandes.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Commande(
          doc.get('nomprenom'),
          doc.get('Prix'),
          doc.get('ID'),
          doc.get('Date').toDate(),
          doc.get('details'),
          doc.get('localisation'),
          doc.get('KM'),
          doc.get('time'),
          doc.get('Comment'),
        );
      }).toList();
    });
  }
}

class Commande {
  String nomprenom;
  String Prix;
  int ID;
  DateTime Date;
  String details;
  String localisation;
  String KM;
  String time;
  String Comment;

  Commande(
    this.nomprenom,
    this.Prix,
    this.ID,
    this.Date,
    this.details,
    this.localisation,
    this.KM,
    this.time,
    this.Comment,
  );
}

/*import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';


class DatabaseService {
  String? userID, carID;
  DatabaseService({this.userID, this.carID});
  // Déclaraction et Initialisation
  CollectionReference _commandes = FirebaseFirestore.instance.collection('commandes');
 // FirebaseStorage _storage = FirebaseStorage.instance;

  // Récuperation de toutes les voitures en temps réel
  Stream<List<commande>> get commandes {
    Query querycommandes = _commandes.orderBy('carTimestamp', descending: true);
    return querycommandes.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return commande(
           doc.get('Prix'),
           doc.get('Date'),
         
        );
      }).toList();
    });
  }

  
  


}


  Future<Car> singleCar(String carID) async {
    final doc = await _commandes.doc(carID).get();
    return Car(
      carID: carID,
      carName: doc.get('carName'),
      carUrlImg: doc.get('carUrlImg'),
      carUserID: doc.get('carUserID'),
      carUserName: doc.get('carUserName'),
      carFavoriteCount: doc.get('carFavoriteCount'),
      carTimestamp: doc.get('carTimestamp'),
    );
  }*/