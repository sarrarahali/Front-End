import 'package:flutter/material.dart';

class CustomIputField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hint;
  final TextInputType? keyboard;
  final  bool obscure ;

  const CustomIputField({
  
    required this.label,
    this.controller,
    this.hint,
    this.keyboard,
     this.obscure = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start ,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 12),
        TextFormField(
          
          obscureText: obscure ,
          focusNode: FocusNode(),
          controller: controller,
          keyboardType: keyboard,
          decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 194, 192, 192),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            ),
            filled: true,
          ),
          //validator: validator,
        )
      ],
    );
  }
}
