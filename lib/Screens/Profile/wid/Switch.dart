import 'package:flutter/material.dart';

class buildSwitch extends StatefulWidget {
  const buildSwitch({super.key});

  @override
  State<buildSwitch> createState() => _buildSwitchState();
}

class _buildSwitchState extends State<buildSwitch> {
  bool lights = false;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          lights ? 'Available' : 'Not Available',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Switch.adaptive(
          value: lights,
          onChanged: (bool value) {
            setState(() {
              lights = value;
            });
          },
          activeColor: Colors.green,
        ),
      ],
    );
  }
}
 