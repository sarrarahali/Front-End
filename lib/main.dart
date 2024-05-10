


import 'package:boy/Screens/MainScreen.dart';
import 'package:boy/Screens/PasswordRecoveryScreen.dart';
import 'package:boy/Screens/SendCodeScreen.dart';
import 'package:boy/Screens/SplachScreen.dart';
import 'package:boy/Screens/home_page.dart';
import 'package:boy/Screens/map.dart';

import 'package:firebase_core/firebase_core.dart';



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp (
      debugShowCheckedModeBanner: false,

      home: 
     // OTPPage( verificationId: '',isTimeOut2: true, )

   Spalch()
      
     //MapScreen()
   //MainScreen()
  
      
    );
  }
}