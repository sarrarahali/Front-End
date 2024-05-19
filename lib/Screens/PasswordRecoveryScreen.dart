

import 'package:boy/Screens/SendCodeScreen.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  final String userEmail;

  const PasswordRecoveryScreen({required this.userEmail});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final phoneController = TextEditingController();
  bool showLoading = false;
  String verificationFailedMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColorbg,
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
                        "NUMÉRO DE TÉLÉPHONE",
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                      
                     Text(
                        "Veuillez renseigner votre numéro de téléphone \n Vous recevrez le code temporaire sous forme un SMS",
                        style: TextStyle(  color:  GlobalColors.text, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30,),
                      buildPhoneNumberInput(),
                      Text(verificationFailedMessage),
                      const SizedBox(height: 20),
                      _buildCustomKeypad(),
                      const SizedBox(height: 40),
                     Align(
  alignment: Alignment.bottomCenter,
  child: SizedBox(
    width: 280, // Set the width to match the phone number input field
    child: CustomButton(
      onPressed: () async {
        setState(() {
          showLoading = true;
        });
        // Retrieve the user's email
        String userEmail = widget.userEmail;
        // Check if the entered phone number matches the one associated with the email
        bool isPhoneNumberValid = await verifyPhoneNumber(userEmail, phoneController.text);
        setState(() {
          showLoading = false;
        });
        if (isPhoneNumberValid) {
          // Phone number is valid, proceed to send code
          await sendCode(phoneController.text);
        } else {
          // Phone number is not valid, show error message
          setState(() {
            verificationFailedMessage = "Le numéro de téléphone ne correspond pas à cet e-mail.";
          });
        }
      },
      title: "Envoyer",
      color: GlobalColors.mainColor,
      borderRadius: 30,
    ),
  ),
),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



   Widget buildPhoneNumberInput() {
    return Container(
      width: 300, // Set desired width
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8), // Adjust padding as needed
            alignment: Alignment.center,
            child: Text(
              '+216',
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: TextStyle(fontSize: 30,letterSpacing: 5, ),
               textAlign: TextAlign.center, 
              onChanged: (value) {
                if (value.length > 8) {
                  phoneController.text = value.substring(0, 8);
                  phoneController.selection = TextSelection.fromPosition(TextPosition(offset: phoneController.text.length));
                }
              },
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color:GlobalColors.text , width: 1),
        ),
      ),
    );
  }

 /* Widget buildPhoneNumberInput() {
  return Container(
    width: 300, // Set desired width
    child: Row(
      children: [
        Container(
          
          alignment: Alignment.center,
          width: 70, 
          child: Text(
            '+216',
            style: TextStyle(fontSize: 30),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            style: TextStyle(fontSize: 30), 
            onChanged: (value) {
              if (value.length > 8) {
               
                phoneController.text = value.substring(0, 8);
                
                phoneController.selection = TextSelection.fromPosition(TextPosition(offset: phoneController.text.length));
              }
            },
          ),
        ),
      ],
    ),
  );
}*/




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
              SizedBox(width: 50 ), // Add space for alignment
              _buildKeypadButton('0'),
              _buildKeypadButton('', icon: Icons.backspace_outlined , onPressed: () {
                if (phoneController.text.isNotEmpty) {
                  phoneController.text = phoneController.text.substring(0, phoneController.text.length - 1);
                }
              }),
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
      icon: icon != null ? Icon(icon, color: Colors.grey , ) : Text(text, style: TextStyle(fontSize: 30)),
    );
  }
Future<bool> verifyPhoneNumber(String email, String phoneNumber) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userData = querySnapshot.docs.first.data();
      dynamic storedPhoneNumber = userData['phone']; // Ensure the storedPhoneNumber is dynamic
      if (storedPhoneNumber != null && storedPhoneNumber.toString() == phoneNumber) {
        return true; // Phone numbers match
      }
    }
  } catch (e) {
    print('Error verifying phone number: $e');
  }

  return false; // Phone numbers don't match or error occurred
}





Future<void> sendCode(String phoneNumber) async {
  setState(() {
    showLoading = true;
  });

  // Retrieve the user's email
  String userEmail = widget.userEmail;

  // Check if the entered phone number matches the one associated with the email
  bool isPhoneNumberValid = await verifyPhoneNumber(userEmail, phoneNumber);

  setState(() {
    showLoading = false;
  });

  if (isPhoneNumberValid) {
    // Phone number is valid, proceed to send code
    try {
      // Concatenate country code with the phone number
      String fullPhoneNumber = "+216$phoneNumber"; 

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            verificationFailedMessage = e.message ?? "An error occurred!";
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to OTPPage and pass verificationId
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPPage(
                verificationId: verificationId,
                isTimeOut2: false, // Set initial isTimeOut value
              ),
            ),
          );
        },
        timeout: Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      setState(() {
        verificationFailedMessage = "An error occurred!";
      });
    }
  } else {
    // Phone number is not valid, show error message
    setState(() {
      verificationFailedMessage = "Le numéro de téléphone ne correspond pas à cet e-mail.";
    });
  }
}




}















/*Widget buildPhoneNumberInput() {
  return Container(
    width: 300, // Set desired width
    child: TextField(
       decoration: InputDecoration(
        // Set prefix text directly within InputDecoration
        prefixText: '+216 ',
        // Optionally, you can style the prefix text
        prefixStyle: TextStyle(fontSize: 15),
      ),
      controller: phoneController,
      keyboardType: TextInputType.phone, // Set keyboardType to phone
      
      onChanged: (value) {
          if (value.length > 8) {
            // Truncate the input to 8 characters if it exceeds 8 characters
            phoneController.text = value.substring(0, 8);
            // Move the cursor to the end of the text
            phoneController.selection = TextSelection.fromPosition(TextPosition(offset: phoneController.text.length));
          }
        },
       
    ),
  );
}*/