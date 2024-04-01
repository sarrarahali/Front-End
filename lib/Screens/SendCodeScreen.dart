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

  final otpController = TextEditingController();
  bool showLoading = false;
  String verificationFailedMessage = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

   String myVerificationId = "";
   bool isTimeOut = false;


  StreamController<ErrorAnimationType>? errorController;

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
    errorController!.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    showLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        :
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        // height: 300,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40),
            Container(
              // height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("assets/otp.gif"),//
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Phone Number Verification',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
              child: RichText(
                text: TextSpan(
                    text: "Enter the code sent to ",
                    children: [
                      TextSpan(
                          text: "+9647501233211",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ],
                    style: TextStyle(color: Colors.black54, fontSize: 15)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                        color: Colors.white,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                hasError ? "please resend the code!" :"",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                        phoneNumber: '+9647501233211',
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
            SizedBox(
              height: 14,
            ),
            Container(
              margin:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
              child: ButtonTheme(
                height: 50,
                child: TextButton(
                  onPressed:  isTimeOut ? null : () async {

                    formKey.currentState!.validate();
                    // conditions for validating
                    if (currentText.length != 6 || currentText != "123456") {
                      errorController!.add(ErrorAnimationType
                          .shake); // Triggering error shake animation
                      setState(() => hasError = true);
                    } else {
                      setState(
                            () {
                          hasError = false;
                        },
                      );
                        setState(() {
                          showLoading = true;
                        });

                        try{
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: myVerificationId, smsCode: otpController.text);

                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);

                        }on FirebaseAuthException catch (e){
                          setState(() {
                            verificationFailedMessage = e.message ?? "error";
                          });
                        }

                        setState(() {
                          showLoading = false;
                        });
                        if(auth.currentUser != null){
                          Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___) => MainScreen()));
                        }
                    }
                  },
                  child: Center(
                      child: Text(
                        "VERIFY".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green.shade200,
                        offset: Offset(1, -2),
                        blurRadius: 5),
                    BoxShadow(
                        color: Colors.green.shade200,
                        offset: Offset(-1, 2),
                        blurRadius: 5)
                  ]),
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
      ),
    ), );
  }
}

/*import 'dart:async';

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
    errorController!.close();
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
                      //borderRadius: BorderRadius.circular(5),
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
                     /* BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.white,
                        blurRadius: 10,
                      )*/
                    ],
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                  )),
            ),
              

                    const SizedBox(height: 10),
                    
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
                        //phoneNumber: '+9647501233211',
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
            SizedBox(
              height: 14,
            ),
            Container(
              margin:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
              child: ButtonTheme(
                height: 50,
                child: TextButton(
                  onPressed:  isTimeOut ? null : () async {

                    formKey.currentState!.validate();
                    // conditions for validating
                    if (currentText.length != 6 || currentText != widget.verificationId) {

                  //  if (currentText.length != 6 || currentText != "123456") {
                      errorController!.add(ErrorAnimationType
                          .shake); // Triggering error shake animation
                      setState(() => hasError = true);
                    } else {
                      setState(
                            () {
                          hasError = false;
                        },
                      );
                        setState(() {
                          showLoading = true;
                        });

                        try{
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: myVerificationId, smsCode: otpController.text);

                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);

                        }on FirebaseAuthException catch (e){
                          setState(() {
                            verificationFailedMessage = e.message ?? "error";
                          });
                        }

                        setState(() {
                          showLoading = false;
                        });
                        if(auth.currentUser != null){
                          Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___) => MainScreen()));
                        }
                    }
                  },
                  child: Center(
                      child: Text(
                        "VERIFY".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green.shade200,
                        offset: Offset(1, -2),
                        blurRadius: 5),
                    BoxShadow(
                        color: Colors.green.shade200,
                        offset: Offset(-1, 2),
                        blurRadius: 5)
                  ]),
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
    
    }
    
 
    
    



 



































import 'dart:async';

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
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen2 extends StatefulWidget {
  final String verificationId;
  final bool isTimeOut2;


   VerificationScreen2({required this.verificationId, required this.isTimeOut2});
 

  @override
  State<VerificationScreen2> createState() => _VerificationScreen2State();
}

class _VerificationScreen2State extends State<VerificationScreen2> {
  late mediaSize;
   final otpController = TextEditingController();
  bool showLoading = false;
  String verificationFailedMessage = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

   String myVerificationId = "";
   bool isTimeOut = false;


  StreamController<ErrorAnimationType>? errorController;

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
    errorController!.close();
    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
     c5.dispose();
      c6.dispose();
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
              
               Text(
              verificationFailedMessage,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
                    const SizedBox(height: 10),
                    _buildSendagaine(),
                     const SizedBox(height: 10),
                     _buildCustomKeypad(),
                     
                    const SizedBox(height: 60),
                    CustomButton(title: "contenir" , onPressed: () {

                     isTimeOut ? null : () async {

                    formKey.currentState!.validate();
                    // conditions for validating
                    if (currentText.length != 6 || currentText != "123456") {
                      errorController!.add(ErrorAnimationType
                          .shake); // Triggering error shake animation
                      setState(() => hasError = true);
                    } else {
                      setState(
                            () {
                          hasError = false;
                        },
                      );
                        setState(() {
                          showLoading = true;
                        });

                        try{
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: myVerificationId, smsCode: otpController.text);

                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);

                        }on FirebaseAuthException catch (e){
                          setState(() {
                            verificationFailedMessage = e.message ?? "error";
                          });
                        }

                        setState(() {
                          showLoading = false;
                        });
                        if(auth.currentUser != null){
                          Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___) => MainScreen() ));
                        }
                    }
                  },
                      
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

           
              c1.text += text;
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
        onPressed: isTimeOut ? () async {
                      setState(() {
                        isTimeOut =  false;
                      });
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '+21656755811',
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

 Widget _buildCustomKeypad() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 20), 
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
        SizedBox(height: 10), 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 70), // Add space for alignment
            _buildKeypadButton('0'),
            _buildKeypadButton(
              '',
              icon: Icons.backspace,
              onPressed: () {
                if (c1.text.isNotEmpty) {
                  c1.text = c1.text
                      .substring(0, c1.text.length - 1);
                }
              },
            ),
          ],
        ),
      ],
    ),
  );
}

}
*/
