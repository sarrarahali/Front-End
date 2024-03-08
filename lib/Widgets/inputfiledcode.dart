import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class inputcode extends StatelessWidget {
  bool first ;
  bool last;
  TextEditingController controller;

   inputcode({super.key,
   required this.first,
  required this.last,
  required this.controller,
  });

  

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: Colors.grey,
                      
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: GlobalColors.childmainColor,
                     
                  ),
                  child: TextField(

onChanged: (value) {
  if(value.isNotEmpty && last ==false ){
    FocusScope.of(context).nextFocus();

}
 else if(value.isEmpty && first ==false ){
    FocusScope.of(context).previousFocus();

}
},               
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.sizeOf(context).width/6,
                      minWidth: MediaQuery.sizeOf(context).width/7
                    )
                  ),
                 ),
                 );
  }
}