
 import 'package:boy/Screens/SendCodeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
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
        body: showLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Spacer(),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: "Phone Number",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                   
                    ElevatedButton(
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
                      child: const Text("SEND"),
                      
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Text(verificationFailedMessage),
                    Spacer(),
                  ],
                ),
              ));
  }
}