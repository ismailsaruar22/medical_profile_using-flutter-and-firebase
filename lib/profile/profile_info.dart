import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_profile_v3/profile/profile_update_screen.dart';

const textStryle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

class ProfileInfo extends StatelessWidget {
  ProfileInfo({Key? key}) : super(key: key);

  static Future getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('info/user/userInfo').get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          title: const Text(
            'Profile Info',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.teal.shade900),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfileUpdateScreen();
                  }));
                },
                child: const Text(
                  'Update Profile Info',
                ))
          ],
        ),
        backgroundColor: Colors.grey.shade100,
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'First Name: ',
                style: textStryle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Last Name',
                style: textStryle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Phone:',
                style: textStryle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Email:',
                style: textStryle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Age:',
                style: textStryle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Blood Group:',
                style: textStryle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Adress:',
                style: textStryle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Gender:',
                style: textStryle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Marital Status:',
                style: textStryle,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
