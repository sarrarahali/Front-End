import 'dart:async';

import 'package:flutter/material.dart';

class trakingscreen extends StatefulWidget {
  const trakingscreen({super.key});

  @override
  State<trakingscreen> createState() => _trakingscreenState();
}

class _trakingscreenState extends State<trakingscreen> {
  final Completer <GoogleMapController>_controller =Completer();
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}