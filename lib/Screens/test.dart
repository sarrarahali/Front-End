import 'package:boy/Widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';



class phonecall extends StatefulWidget {
  final number = '+21656755811';

  phonecall();

  @override
  _phonecallState createState() => _phonecallState();
}

class _phonecallState extends State<phonecall> {


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Command Details'),
      ),
      body: Center(
        child: IconButton(
          onPressed: () async{
            FlutterPhoneDirectCaller.callNumber('+1267998777');
          // lunch ('tel://$number');
          },
          color: GlobalColors.childmainColor,
          icon: Image.asset(
            "images/phone.png",
            color: GlobalColors.mainColor,
          ),
        ),
      ),
    );
  }

  
}
