import 'package:boy/Screens/Profile/wid/Switch.dart';
import 'package:boy/Widgets/CustomInputField.dart';

import 'package:flutter/material.dart';


class buildInformation extends StatefulWidget {
  const buildInformation({super.key});

  @override
  State<buildInformation> createState() => _buildInformationState();
}

class _buildInformationState extends State<buildInformation> {

  final TextEditingController? nameController = TextEditingController();
  final TextEditingController? emailController = TextEditingController();
  final TextEditingController? phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildImage(),
          CustomIputField(
            
            label: "name",
            keyboard: TextInputType.name,
            controller: nameController,
          ),
          SizedBox(height: 10,),
          CustomIputField(
             
            label: "email",
            keyboard: TextInputType.emailAddress,
            controller: emailController,
          ),
           SizedBox(height: 10,),
          CustomIputField(
           
            label: "phone",
            keyboard: TextInputType.phone,
            controller: phoneController,
          ),
          const SizedBox(height: 20),
       Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Delivery status",
    textAlign: TextAlign.right, 
    style: TextStyle(
      color: Colors.grey,
      fontSize: 16,
    ),
  ),
),
          buildSwitch(),
        ],
      ),
    );
  }


 Widget buildImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
       IconButton(
  icon: Image.asset(
    'images/edit.jpg', 
    width: 24, 
    height: 24, 
  ),
  onPressed: () {
  },
),
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 3,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
            shape: BoxShape.circle,
          ),
        ),
        

        IconButton(
  icon: Image.asset(
    'images/logout.jpg', // Replace 'example.png' with your image path
    width: 24, // Set the width of the image
    height: 24, // Set the height of the image
  ),
  onPressed: () {
    // Add your onPressed functionality here
  },
),

      ],
    );
  }
}

 
  
