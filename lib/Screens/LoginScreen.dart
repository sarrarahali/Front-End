import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:boy/Widgets/CustomInputField.dart';
import 'package:boy/Widgets/Remember.dart';


import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor:  GlobalColors.mainColorbg ,
body: Stack(
children: [
  Container(
    child: const Padding(padding:EdgeInsets.only(top: 200, left: 200) ),
    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("images/logoshort.png") )),
  ),
  Padding(padding: const EdgeInsets.only(top: 150),
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
                padding: const EdgeInsets.only(left: 18.0, right: 18),
child: SingleChildScrollView(
  child: Column(
    
    crossAxisAlignment: CrossAxisAlignment.center,
     children: [
      const SizedBox(height: 20),
 
      const Text(
        "connectez-vous",
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.w800,
        ),
      ),
      const Padding(padding: EdgeInsets.all(8)),
      const Text(
        "Identifiez-vous pour assurer une livraison facile et rapide",
        style: TextStyle(color: Colors.grey, fontSize: 18,),
        textAlign: TextAlign.center,
      ), 
      const Padding(padding:EdgeInsets.symmetric(vertical : 60)),
      const CustomIputField(label: 'Numéro ID', keyboard: TextInputType.number),
      const SizedBox(height: 20,),
      const CustomIputField(label: 'Mot de passe', keyboard: TextInputType.text, obscure: true, ),
      const RememberPW(),
      const SizedBox(height: 70),
Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
  Expanded(

    flex: 2,
    child:
    CustomButton(title: "ID FACE", onPressed: () {
      },  color: GlobalColors.mainColorbg , borderRadius: 30,image: const AssetImage('images/face.png'), onTap: () {  },
 )),
    
      const SizedBox(width: 10), 
      Expanded(
         flex: 3,
        child: CustomButton(title: "Se connecter",  onPressed: () {
      },  color: GlobalColors.mainColor,   onTap: () {  },))
       
],

)
    ],
  ) ,
),
 )
  )
  ),
],
),
    );
  }
}











 
 


