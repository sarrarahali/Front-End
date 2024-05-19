import 'package:boy/Screens/LoginScreen.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:boy/Screens/PasswordRecoveryScreen.dart';

class RememberPW extends StatefulWidget {
  final String userEmail; // Add userEmail parameter
  const RememberPW({Key? key,  required this.userEmail}) : super(key: key);

  @override
  _RememberPWState createState() => _RememberPWState();
}

class _RememberPWState extends State<RememberPW> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        GestureDetector(
         onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  PasswordRecoveryScreen(userEmail: widget.userEmail)),
            );
          },
          child: Text(
            "Mot de passe oublié ?",
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: GlobalColors.TextColor ,
            ),
          ),
        ),
      ],
    );
  }
}
