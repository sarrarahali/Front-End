
import 'package:boy/Screens/MainScreen.dart';
import 'package:boy/Screens/SplachScreen.dart';



import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(){
 // WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return  const GetMaterialApp (
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(
        //scaffoldBackgroundColor: GlobalColors.mainColor ),
      home: MainScreen()
    );
  }
}