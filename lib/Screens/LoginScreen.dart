import 'package:boy/Screens/MainScreen.dart';
import 'package:boy/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomButton.dart';
import 'package:boy/Widgets/CustomInputField.dart';
import 'package:boy/Widgets/Remember.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _IDController = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();

  String _ID = "";
  String _password = "";

  void _handleLogin() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _ID,
        password: _password,
      );
   
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        print('Invalid credentials.');
      } else {
        print('Error: $e');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColorbg,
      body: Stack(
        children: [
          Container(
            child: const Padding(padding: EdgeInsets.only(top: 200, left: 200)),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/logoshort.png"))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
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
                  child: Form(
                    key: _formKey,
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
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 60)),
                        CustomIputField (
                          label: 'Numéro ID',
                          keyboard: TextInputType.emailAddress ,
                          controller: _IDController,
                          /*validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your ID";
                            } else if (value.length != 8) {
                              return "ID must be 8 characters long";
                            }
                            return null;
                          },*/
                          onChanged: (String value) {
                            setState(() => _ID = value);
                          },
                        ),
                        const SizedBox(height: 20,),
                        CustomIputField(
                          label: 'Mot de passe',
                          keyboard: TextInputType.text,
                          obscure: true,
                          controller: _PasswordController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            } else if (value.length < 6) {
                              return "Password must be at least 6 characters long";
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            setState(() => _password = value);
                          },
                        ),
                        RememberPW(),
                        const SizedBox(height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomButton(
                                  title: "ID FACE",
                                  onPressed: () {},
                                  color: GlobalColors.mainColorbg,
                                  borderRadius: 30,
                                  image: const AssetImage('images/face.png'),
                                  onTap: () {}),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: CustomButton(
                                  title: "Se connecter",
                                  onPressed: () async {
   if (_formKey.currentState!.validate()) {
                                      _handleLogin();
                                    }
},

                                  color: GlobalColors.mainColor,
                                  onTap: () {}),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
