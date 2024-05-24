import 'dart:io';

import 'package:boy/Screens/LoginScreen.dart';
import 'package:boy/Screens/Profile/wid/Switch.dart';
import 'package:boy/Widgets/Colors.dart';

import 'package:boy/Widgets/CustomInputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/*
class buildInformation extends StatefulWidget {
  const buildInformation({super.key});

  @override
  State<buildInformation> createState() => _buildInformationState();
}

class _buildInformationState extends State<buildInformation> {
final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
File? _imageFile;
  final picker = ImagePicker();
  String? _imageUrl;
  @override
  void initState() {
    super.initState();
    // Call a method to load user information
    loadUserInfo();
  }



Future<void> loadUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      nameController.text = user.displayName ?? '';
      emailController.text = user.email ?? '';
      phoneController.text = user.phoneNumber ?? '';
      // Fetch and set the profile image URL if exists
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _imageFile = userDoc['profileImage'] != null ? File(userDoc['profileImage']) : null;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _uploadImageToStorage();
    }
  }


   Future<void> _saveImage() async {
    if (_imageFile == null) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        String fileName = 'profile_images/${user.uid}.png';
        UploadTask uploadTask = FirebaseStorage.instance.ref().child(fileName).putFile(_imageFile!);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'profileImage': downloadUrl,
        });
        setState(() {
          _imageUrl = downloadUrl;
        });
        await user.updateProfile(photoURL: downloadUrl);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile image saved successfully')));
      } catch (e) {
        print('Error uploading image: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save profile image')));
      }
    }
  }

  Future<void> _uploadImageToStorage() async {
    if (_imageFile == null) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        String fileName = 'profile_images/${user.uid}.png';
        UploadTask uploadTask = FirebaseStorage.instance.ref().child(fileName).putFile(_imageFile!);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'profileImage': downloadUrl,
        });
       
        await user.updateProfile(photoURL: downloadUrl);
      } catch (e) {
        print('Error uploading image: $e');
      }
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
           SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveImage,
            child: Text('Save Profile Image'),
          ),
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
          onPressed: _pickImage,
        ),
        _imageUrl != null
            ? CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(_imageUrl!),
              )
            : CircleAvatar(
                radius: 55,
                backgroundColor: GlobalColors.text,
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
}*/



import 'dart:io';

import 'package:boy/Screens/LoginScreen.dart';
import 'package:boy/Screens/Profile/wid/Switch.dart';
import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/CustomInputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BuildInformation extends StatefulWidget {
  const BuildInformation({super.key});

  @override
  State<BuildInformation> createState() => _BuildInformationState();
}

class _BuildInformationState extends State<BuildInformation> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  File? _imageFile;
  String? _imageUrl;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

 // Inside your _BuildInformationState class

Future<void> loadUserInfo() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    nameController.text = user.displayName ?? '';
    emailController.text = user.email ?? '';
    phoneController.text = user.phoneNumber ?? '';
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (userDoc.exists && mounted) {
      setState(() {
        _imageUrl = userDoc['profilePicture'];
      });
    }
  }
}

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && mounted) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageUrl = null; // Clear URL to show picked file
      });
    }
  }

  Future<void> _saveImage() async {
    if (_imageFile == null) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        String fileName = 'profile_images/${user.uid}.png';
        UploadTask uploadTask = FirebaseStorage.instance.ref().child(fileName).putFile(_imageFile!);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'profilePicture': downloadUrl,
        });
        if (mounted) {
          setState(() {
            _imageUrl = downloadUrl;
            _imageFile = null; // Clear the file after upload
          });
        }
        await user.updateProfile(photoURL: downloadUrl);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile image saved successfully')));
        }
      } catch (e) {
        print('Error uploading image: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save profile image')));
        }
      }
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
            label: "Name",
            keyboard: TextInputType.name,
            controller: nameController,
          ),
          SizedBox(height: 10),
          CustomIputField(
            label: "Email",
            keyboard: TextInputType.emailAddress,
            controller: emailController,
          ),
          SizedBox(height: 10),
          CustomIputField(
            label: "Phone",
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
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveImage,
            child: Text('Save Image'),
          ),
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
          onPressed: _pickImage,
        ),
        _imageFile != null
            ? CircleAvatar(
                radius: 55,
                backgroundImage: FileImage(_imageFile!),
              )
            : _imageUrl != null
                ? CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(_imageUrl!),
                  )
                : CircleAvatar(
                    radius: 55,
                    backgroundColor: GlobalColors.text,
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
            } catch (e) {
              print('Error signing out: $e');
            }
          },
        ),
      ],
    );
  }
}
