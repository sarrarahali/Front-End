

import 'package:boy/Screens/SendCodeScreen.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
 final phoneController = TextEditingController();
  bool showLoading = false;
  String verificationFailedMessage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


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
      SizedBox(height: 20),
 
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
       Text(verificationFailedMessage),
     const SizedBox(height:20),
     _buildCustomKeypad(),
     const SizedBox(height:40),
        Align(
      alignment: Alignment.bottomLeft ,
      child: CustomButton(
         onTap: () {   },
        title: "Envoyer",
      
   onPressed: () async {

                        setState(() {
                          showLoading = true;
                        });
                        await FirebaseAuth.instance.verifyPhoneNumber(

                          phoneNumber: phoneController.text,
                          verificationCompleted: (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {
                            setState(() {
                              showLoading = false;
                            });
                            setState(() {
                              verificationFailedMessage = e.message ?? "error!";
                            });
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            setState(() {
                              showLoading = false;
                            });
                            Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___) => OTPPage(isTimeOut2: false , verificationId:verificationId)));
                          },
                          timeout: const Duration(seconds: 10),
                          codeAutoRetrievalTimeout: (String verificationId) {

                            Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___) => OTPPage(isTimeOut2: true ,verificationId:verificationId)));

                          },
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
  return TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: "Phone Number",
                      ),
                    );
}

 Widget _buildCustomKeypad() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 20), // Add padding for spacing
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment
          children: [
            _buildKeypadButton('1'),
            _buildKeypadButton('2'),
            _buildKeypadButton('3'),
          ],
        ),
        SizedBox(height: 10), // Add space between rows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment
          children: [
            _buildKeypadButton('4'),
            _buildKeypadButton('5'),
            _buildKeypadButton('6'),
          ],
        ),
        SizedBox(height: 10), // Add space between rows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment
          children: [
            _buildKeypadButton('7'),
            _buildKeypadButton('8'),
            _buildKeypadButton('9'),
          ],
        ),
        SizedBox(height: 10), // Add space between rows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment
          children: [
            SizedBox(width: 70), // Add space for alignment
            _buildKeypadButton('0'),
            _buildKeypadButton(
              '',
              icon: Icons.backspace,
              onPressed: () {
                if (phoneController.text.isNotEmpty) {
                  phoneController.text = phoneController.text
                      .substring(0, phoneController.text.length - 1);
                }
              },
            ),
          ],
        ),
      ],
    ),
  );
}
  Widget _buildKeypadButton(String text, {IconData? icon, Function()? onPressed}) {
    return IconButton(
      onPressed: onPressed != null
          ? onPressed
          : () {
              phoneController.text += text;
            },
      icon: icon != null ? Icon(icon) : Text(text, style: TextStyle(fontSize: 30)),
    );
    
  }

} 