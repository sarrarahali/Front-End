import 'package:boy/Screens/SendCodeScreen.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../Widgets/CustomKeypad.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  late TextEditingController phoneNumber = TextEditingController();

 

 
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
backgroundColor:  GlobalColors.mainColorbg ,
body: Stack(
children: [
  Container(
    child: const Padding(padding:EdgeInsets.only(top: 200, left: 200) ),
    decoration: const BoxDecoration(image: const DecorationImage(image: AssetImage("images/logoshort.png") )),
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
        "NUMÉRO DE TÉLÉPHONE",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      const Padding(padding: EdgeInsets.all(8)),
      const Text(
        "Veuillez renseigner votre numéro de téléphone Vous recevrez le code temporaire sous forme un SMS",
        style: TextStyle(color: Colors.grey, fontSize: 18,),
        textAlign: TextAlign.center,
      ), 
      const SizedBox(height:40),
     buildPhoneNumberInput( ),
     const SizedBox(height:20),
     const CustomKeypad(),
     const SizedBox(height:40),
        Align(
      alignment: Alignment.bottomLeft ,
      child: CustomButton(
         onTap: () {   },
        title: "Envoyer",
        onPressed: () {
  String phone = phoneNumber.text; // Get the phone number
 Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => VerificationScreen2(phoneNumber.text)),
);

},

        color: GlobalColors.mainColor,
        borderRadius: 30,
      ),
    ),
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

Widget buildPhoneNumberInput() {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: const Text(
          '+216',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
       Expanded(
        child: TextField(
         controller: phoneNumber,
          decoration: InputDecoration(
         
          
          ),
          keyboardType: TextInputType.phone,
        ),
      ),
    ],
  );
}





void dispose(){
  phoneNumber.dispose();
}




}











 
 



