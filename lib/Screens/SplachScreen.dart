import 'dart:async';

import 'package:boy/Screens/LoginScreen.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Spalch extends StatelessWidget {
  const Spalch({Key? key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
  Get.to(LoginScreen());
});


    return Scaffold(
      backgroundColor: GlobalColors.mainColor, // Set the background color here
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Image.asset("images/splash-screen.png"), // Your splash image
        ),
      ),
    );
  }
}
