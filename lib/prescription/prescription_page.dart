import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import '../qr/qr_share_page.dart';

class PrescriptionPage extends StatefulWidget {
  String paitientId;

  PrescriptionPage({Key? key, required this.paitientId}) : super(key: key);

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  TextEditingController medicineContent = TextEditingController();
  TextEditingController testsContent = TextEditingController();
  TextEditingController commentsContent = TextEditingController();

  String user = FirebaseAuth.instance.currentUser!.uid;

  // CollectionReference ref = FirebaseFirestore.instance
  //     .collection('users data')
  //     .doc(FirebaseAuth.instance.currentUser!.email.toString())
  //     .collection('appoinments');

  @override
  Widget build(BuildContext context) {
    print(user);
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
                  FirebaseFirestore.instance
                      .collection('users data')
                      .doc(widget.paitientId.toString())
                      .collection('appoinments')
                      .add({
                    'medicine': medicineContent.text,
                    'tests': testsContent.text,
                    'comments': commentsContent.text,
                    'postId': const Uuid().v1(),
                    'doctorUid': user,
                    'paitientUid': widget.paitientId.toString(),
                  });
                },
                child: Text('Submit'))
          ],
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
