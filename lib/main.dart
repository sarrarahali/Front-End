


import 'package:boy/Screens/MainScreen.dart';
import 'package:boy/Screens/PasswordRecoveryScreen.dart';
import 'package:boy/Screens/Profile/Screen/InformationScreen.dart';
import 'package:boy/Screens/Profile/Screen/ProfileScreen.dart';
import 'package:boy/Screens/SendCodeScreen.dart';
import 'package:boy/Screens/SplachScreen.dart';
import 'package:boy/Screens/aa.dart';
import 'package:boy/Screens/home_page.dart';
import 'package:boy/Screens/map.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,
);
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp (
      debugShowCheckedModeBanner: false,

      home: 
      Spalch()

     // OTPPage( verificationId: '',isTimeOut2: true, )

   
      
     //MapScreen()
  // MainScreen()

   
    );
  }
}