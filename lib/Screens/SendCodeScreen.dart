
import 'dart:async';

import 'package:boy/Screens/MainScreen.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';


class OTPPage extends StatefulWidget {
  OTPPage({required this.verificationId, required this.isTimeOut2});
  final String verificationId;
  final bool isTimeOut2;


  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  final otpController = TextEditingController();
  bool showLoading = false;
  String verificationFailedMessage = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

   String myVerificationId = "";
   bool isTimeOut = false;


  StreamController<ErrorAnimationType>? errorController;
   late Size mediaSize;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    myVerificationId = widget.verificationId;
    isTimeOut = widget.isTimeOut2;
    super.initState();
  }

  
@override
void dispose() {
  // Cancel any ongoing asynchronous operations
  errorController?.close();
  super.dispose();
}



  @override
  Widget build(BuildContext context) {
       mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: GlobalColors.mainColorbg ,
      body: Stack(
        children: [
          Container(
            child: const Padding(padding: EdgeInsets.only(top: 200, left: 200)),
            decoration: const BoxDecoration(image: const DecorationImage(image: AssetImage("images/logoshort.png"))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
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
                        "VÉRIFICATION CODE",
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                      
                    Padding(padding: EdgeInsets.all(40)),
                    
                  
                Form(
              key: formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 6) {
                        return "you should enter all SMS code";
                      }
                      else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      
                      fieldHeight: 50,
                      fieldWidth: 40,
                      //activeFillColor: GlobalColors.text,
                            // inactiveFillColor: Colors.black,
                             // selectedFillColor: Colors.black,
                              activeColor:GlobalColors.text,
                              inactiveColor: GlobalColors.text,
                              selectedColor: GlobalColors.text,
                     
                    ),
                    
                    animationDuration: Duration(milliseconds: 300),
                   errorAnimationController: errorController,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    boxShadows: [
                     
                    ],
                    onCompleted: (v) {
                        _verifyOTP(v);
                      },
                    
                  )),
            ),
                    const SizedBox(height: 10),
                     Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "échec d'envoie ?",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
               TextButton(
  onPressed: () async {
    try {
      // Resetting any previous error message
      setState(() {
        verificationFailedMessage = "";
      });

      // Resend OTP logic
      await FirebaseAuth.instance.verifyPhoneNumber(
       
        timeout: Duration(seconds: 60), // Timeout duration
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            verificationFailedMessage = e.message ?? "Error!";
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            myVerificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("Error resending OTP: $e");
      // Handle any errors here
    }
  },
  child: Text(
    "Cliquer ici",
    style: TextStyle(
      color: GlobalColors.mainColor,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  ),
)
              ],
            ),
            
            _buildCustomKeypad(),
            SizedBox(
              height: 14,
            ),
          
            SizedBox(
              height: 16,
            ),
            Text(
              verificationFailedMessage,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      )
              )
            )
          )
            ]
          )
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
            SizedBox(width: 50), // Add space for alignment
            _buildKeypadButton('0'),
            _buildKeypadButton(
              '',
              icon: Icons.backspace_outlined,
              onPressed: () {
                if (otpController.text.isNotEmpty) {
                  otpController.text =otpController .text
                      .substring(0, otpController.text.length - 1);
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
              otpController.text += text;
            },
      icon: icon != null ? Icon(icon, color: Colors.grey) : Text(text, style: TextStyle(fontSize: 30)),
    );
    
  }


Future<void> _verifyOTP(String enteredOTP) async {
  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: myVerificationId,
      smsCode: enteredOTP,
    );
    await _auth.signInWithCredential(credential);
    if (_auth.currentUser != null) {
    
      Navigator.pushReplacement(
        context ,
        MaterialPageRoute(builder:(context)  => MainScreen()),
      );
     
     
    }
  } catch (e) {
  if (mounted) {
    setState(() {
      verificationFailedMessage = "Invalid OTP. Please try again.";
    });
  }
}

}

    }

    






    
 
    
    



 































