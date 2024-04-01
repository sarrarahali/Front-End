import 'package:boy/Screens/LoginScreen.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:boy/Screens/PasswordRecoveryScreen.dart';

class RememberPW extends StatefulWidget {
  const RememberPW({Key? key}) : super(key: key);

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
              MaterialPageRoute(builder: (context) => const LogInPage()),
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
