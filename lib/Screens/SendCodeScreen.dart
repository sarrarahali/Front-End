import 'package:boy/Screens/MainScreen.dart';
import 'package:boy/Screens/PasswordRecoveryScreen.dart';
import 'package:boy/Screens/PasswordRecoveryScreen.dart';
import 'package:boy/Widgets/Controller.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:boy/Widgets/CustomKeypad.dart';
import 'package:boy/Widgets/inputfiledcode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerificationScreen2 extends StatefulWidget {
 final  String phone;
   VerificationScreen2(this.phone, {Key? key}) : super(key: key);
 

  @override
  State<VerificationScreen2> createState() => _VerificationScreen2State();
}

class _VerificationScreen2State extends State<VerificationScreen2> {
  String? verifId;
   FirebaseAuth auth = FirebaseAuth.instance;
   late Size mediaSize;
  late TextEditingController _phoneNumberController;
   @override
  void initState() {
    phoneauth();
    super.initState();
    _phoneNumberController = TextEditingController();
  }
 @override
  void dispose() {
    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
     c5.dispose();
      c6.dispose();
      _phoneNumberController.dispose();

    super.dispose();
  }
  
  @override
 
  Widget build(BuildContext context) {

 mediaSize = MediaQuery.of(context).size;
     _phoneNumberController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: [
          Positioned(
            top: 80,
            child: _buildTop(),
          ),
          Positioned(
            bottom: 0,
            child: _buildBottom(),
          ),
        ],
      ),
    );
  }


   Widget _buildTop() {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          
        ],
      ),
    );
  }



 Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "VÉRIFICATION CODE",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(40)),
                    
                  

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                 inputcode(controller: c1,first:true  , last: false ),
                 inputcode(controller: c2,first:false  , last: false ),
                 inputcode(controller: c3,first:false  , last: false ),
                 inputcode(controller: c4,first:false  , last: false ),
                 inputcode(controller: c5,first:false  , last: false ),
                  inputcode(controller: c6,first:false  , last: true ), 
                  ],
                ),
              

                    const SizedBox(height: 10),
                    _buildSendagaine(),
                     const SizedBox(height: 10),
                     CustomKeypad(),
                   
                   
                    
                    const SizedBox(height: 60),
                    CustomButton(title: "contenir" , onPressed: () {
                      sentcode();
                      
                    }, color: Colors.blue, onTap: () {
                      
                    },)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }










 Widget _buildKeypadButton(String text, {IconData? icon, Function()? onPressed}) {
    return IconButton(
      onPressed: onPressed != null
          ? onPressed
          : () {
              _phoneNumberController.text += text;
            },
      icon: icon != null ? Icon(icon) : Text(text, style: TextStyle(fontSize: 30)),
    );
  }





Widget _buildSendagaine() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "échec d'envoie? ",
        
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20,
          color: Colors.grey,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Text(
          "Cliquer ici",
          textAlign: TextAlign.center,
          style: TextStyle(
             fontSize: 20,
            decoration: TextDecoration.underline, 
            color: Colors.deepPurple, 
          ),
        ),
      ),
    ],
  );
}




void phoneauth() async {
  await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber:widget.phone,
  verificationCompleted: (PhoneAuthCredential credential) {},
  verificationFailed: (FirebaseAuthException e) {},
  
  codeSent: (String verificationId, int? resendToken) async {
      verifId = verificationId;
  },
  codeAutoRetrievalTimeout: (String verification){}
  
);
}

sentcode()async{
  try{
 String smsCode = c1.text+c2.text+c3.text+c4.text+c5.text+c6.text;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verifId! , smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential) .then((value) {
   if(value.user !=null){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
   }



    });
    
}
catch(ex){

}
}



}
