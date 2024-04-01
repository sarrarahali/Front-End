import 'package:flutter/material.dart';

class CustomKeypad extends StatefulWidget {
    final Function(String) onButtonPressed;
  const CustomKeypad({Key? key,  required this.onButtonPressed}) : super(key: key);

  @override
  State<CustomKeypad> createState() => _CustomKeypadState();
}

class _CustomKeypadState extends State<CustomKeypad> {
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     
      padding: EdgeInsets.symmetric(horizontal: 60), // Add padding for spacing
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
          SizedBox(height: 30), // Add space between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment
            children: [
              _buildKeypadButton('4'),
              _buildKeypadButton('5'),
              _buildKeypadButton('6'),
            ],
          ),
          SizedBox(height: 30 ), // Add space between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment
            children: [
              _buildKeypadButton('7'),
              _buildKeypadButton('8'),
              _buildKeypadButton('9'),
            ],
          ),
          SizedBox(height: 30), // Add space between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment
            children: [
              SizedBox(width: 70), // Add space for alignment
              _buildKeypadButton('0'),
              _buildKeypadButton(
                '',
                icon: Icons.backspace,
                onPressed: () {
                  if (_phoneNumberController.text.isNotEmpty) {
                    _phoneNumberController.text = _phoneNumberController.text
                        .substring(0, _phoneNumberController.text.length - 1);
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
            widget.onButtonPressed(text); // Invoke the callback function
          },
    icon: icon != null ? Icon(icon) : Text(text, style: TextStyle(fontSize: 30)),
  );
}
}

