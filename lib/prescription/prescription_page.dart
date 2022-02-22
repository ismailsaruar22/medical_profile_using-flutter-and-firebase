import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:medical_profile_v3/doctor/doctor_login_page.dart';
import 'package:medical_profile_v3/prescription/details_page.dart';
import 'package:medical_profile_v3/prescription/prescripton_data_from_firebase.dart';
import 'package:medical_profile_v3/screens/login_screen.dart';

import '../profile/profile_update_screen.dart';
import '../qr/qr_share_page.dart';
import '../screens/history_page.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({Key? key}) : super(key: key);

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  TextEditingController medicineContent = TextEditingController();
  TextEditingController testsContent = TextEditingController();
  TextEditingController commentsContent = TextEditingController();

  CollectionReference ref =
      FirebaseFirestore.instance.collection('appointments');
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
            showModalBottomSheet(
                context: context,
                builder: (context) => const QrSharePage(),
                elevation: 20.0,
                isScrollControlled: true,
                backgroundColor: Colors.teal.shade900);
          },
          label: const Text('Share or Scan'),
          icon: const Icon(Icons.qr_code),
          backgroundColor: Colors.pink,
        ),
        appBar: AppBar(
          title: const Text('Write Prescription'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  ref.add({
                    'medicine': medicineContent.text,
                    'tests': testsContent.text,
                    'comments': commentsContent.text,
                  });
                },
                child: Text('Submit'))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                accountName: Container(
                    child: const Text(
                  'XYZ',
                  style: TextStyle(color: Colors.black),
                )),
                accountEmail: Container(
                    child: Text(
                  FirebaseAuth.instance.currentUser!.email.toString(),
                  style: TextStyle(color: Colors.black),
                )),
                currentAccountPicture: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                              'https://thumbs.dreamstime.com/z/businessman-icon-image-male-avatar-profile-vector-glasses-beard-hairstyle-179728610.jpg',
                            ),
                          ),
                    Positioned(
                        bottom: -5,
                        left: 80,
                        child: IconButton(
                          icon: const Icon(Icons.add_a_photo),
                          color: Colors.teal,
                          onPressed: () {},
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Update profile info'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfileUpdateScreen();
                  }));
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.logout),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
                title: Text('Logout'),
              )
            ],
          ),
        ),
        body: kIsWeb
            ? Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Text('Paitient name: Ismail Mia'),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: TextField(
                                  controller: testsContent,
                                  maxLines: null,
                                  expands: true,
                                  decoration: const InputDecoration(
                                      hintText: 'Tests',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      contentPadding: EdgeInsets.all(10)),
                                ),
                              )),
                          Expanded(
                              flex: 7,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: TextField(
                                  controller: medicineContent,
                                  maxLines: null,
                                  expands: true,
                                  decoration: const InputDecoration(
                                      hintText: 'Medicines',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      contentPadding: EdgeInsets.all(10)),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: TextField(
                                  controller: commentsContent,
                                  maxLines: null,
                                  expands: true,
                                  decoration: const InputDecoration(
                                      hintText: 'Doctors comment',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      contentPadding: EdgeInsets.all(10)),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                child: Column(
                  children: [
                    const Text('Paitient name: Ismail Mia'),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: TextField(
                                  controller: testsContent,
                                  maxLines: null,
                                  expands: true,
                                  decoration: const InputDecoration(
                                      hintText: 'Tests',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      contentPadding: EdgeInsets.all(10)),
                                ),
                              )),
                          Expanded(
                              flex: 7,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: TextField(
                                  controller: medicineContent,
                                  maxLines: null,
                                  expands: true,
                                  decoration: const InputDecoration(
                                      hintText: 'Medicines',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      contentPadding: EdgeInsets.all(10)),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: TextField(
                                  controller: commentsContent,
                                  maxLines: null,
                                  expands: true,
                                  decoration: const InputDecoration(
                                      hintText: 'Doctors comment',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      contentPadding: EdgeInsets.all(10)),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
