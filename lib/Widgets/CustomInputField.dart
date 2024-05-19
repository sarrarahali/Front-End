import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';

class CustomIputField extends StatelessWidget {
  final Widget? suffixIcon;
  final String label;
  final TextEditingController? controller;
  final String? hint;
  final TextInputType? keyboard;
  final  bool obscure ;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
final FocusNode? focusNode; 
  const CustomIputField({
  this.suffixIcon,
    required this.label,
    this.controller,
    this.hint,
    this.keyboard,
     this.obscure = false,
     this.validator,
     this.onChanged,
      this.focusNode, 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start ,
      children: [
        Text(
          label,
          style:  TextStyle(
            color:  GlobalColors.TextColor,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
           
          obscureText: obscure ,
          focusNode:  focusNode,
          controller: controller,
          keyboardType: keyboard,
            style: TextStyle(fontSize: 20), 
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            fillColor: GlobalColors.TextFormField,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            ),
            filled: true,
          ),
          validator: validator,
           onChanged: onChanged,
        )
      ],
    );
  }
}
