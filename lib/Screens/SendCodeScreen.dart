

import 'dart:async';

import 'package:boy/Screens/MainScreen.dart';
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
    
    void cancelOperations() {
    // Cancel any ongoing asynchronous operations here
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
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor:Colors.white,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    errorAnimationController: errorController,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: const Color.fromARGB(255, 214, 11, 11),
                        blurRadius: 10,
                      )
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
                  "Didn't receive the code? ",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                TextButton(
                    onPressed: isTimeOut ? () async {
                      setState(() {
                        isTimeOut =  false;
                      });
                      await FirebaseAuth.instance.verifyPhoneNumber(
                    
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
                            myVerificationId = verificationId;
                          });
                        },
                        timeout: const Duration(seconds: 10),
                        codeAutoRetrievalTimeout: (String verificationId) {
                          setState(() {
                            isTimeOut =  true;
                          });
                        },
                      );
                    } : null,
                    child: Text(
                      "RESEND",
                      style: TextStyle(
                          color: Color(0xFF91D3B3),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ))
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
          
            ]
          )
        )
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
            SizedBox(width: 70), // Add space for alignment
            _buildKeypadButton('0'),
            _buildKeypadButton(
              '',
              icon: Icons.backspace,
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
      icon: icon != null ? Icon(icon) : Text(text, style: TextStyle(fontSize: 30)),
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

    
 
    
    



 































