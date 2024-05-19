import 'package:boy/Screens/LoginScreen.dart';
import 'package:boy/Screens/Profile/wid/Switch.dart';

import 'package:boy/Widgets/CustomInputField.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


class buildInformation extends StatefulWidget {
  const buildInformation({super.key});

  @override
  State<buildInformation> createState() => _buildInformationState();
}

class _buildInformationState extends State<buildInformation> {
final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call a method to load user information
    loadUserInfo();
  }

  void loadUserInfo() async {
      
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {

      // Set the values of text controllers with user information
      nameController.text = user.displayName ?? '';
      emailController.text = user.email ?? '';
      // You can fetch additional user info like phone number if needed
       phoneController.text = user.phoneNumber ?? '';
    }
  }

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
           Align(alignment: Alignment.centerLeft,
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
    'images/edit.png', 
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
    'images/logout.png',
    width: 24,
    height: 24,
  ),
  onPressed: () async {
    try {
      await FirebaseAuth.instance.signOut();
      // After signing out, navigate the user back to the login screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      // Handle sign-out errors, if any.
      print('Error signing out: $e');
    }
  },
),

      ],
    );
  }
}


  

  
/*

import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package



class buildInformation extends StatefulWidget {
  final String userId;

  const buildInformation({required this.userId, Key? key}) : super(key: key);

  @override
  State<buildInformation> createState() => _buildInformationState();
}

class _buildInformationState extends State<buildInformation> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget initializes
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      // Get the user document from Firestore
      var userData = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();

      // Set the text in the controllers to the fetched data
      nameController.text = userData['name'] ?? ''; // Replace 'name' with the field name in your Firestore document
      emailController.text = userData['email'] ?? ''; // Replace 'email' with the field name in your Firestore document
      phoneController.text = userData['phone'] ?? ''; // Replace 'phone' with the field name in your Firestore document
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          onPressed: () {},
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
            'images/logout.jpg',
            width: 24,
            height: 24,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
*/