import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_profile_v3/utills/utils.dart';

class HomePageInstuction extends StatefulWidget {
  String paitientId;

  HomePageInstuction({Key? key, required this.paitientId}) : super(key: key);

  @override
  _HomePageInstuctionState createState() => _HomePageInstuctionState();
}

class _HomePageInstuctionState extends State<HomePageInstuction> {
  TextEditingController medicineContent = TextEditingController();
  TextEditingController testsContent = TextEditingController();
  TextEditingController commentsContent = TextEditingController();

  String user = FirebaseAuth.instance.currentUser!.uid;
  var userData = {};
  bool _isLoading = false;

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var userRoleSnap = await FirebaseFirestore.instance
          .collection('users data')
          .doc(FirebaseAuth.instance.currentUser!.email.toString())
          .get();

      userData = userRoleSnap.data()!;
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    //String postId = const Uuid().v1();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          title: const Text('Write instruction to the patient'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  CollectionReference ref = FirebaseFirestore.instance
                      .collection('users data')
                      .doc(widget.paitientId.toString())
                      .collection('instructions');

                  String docId = ref.doc().id;

                  ref.doc(widget.paitientId.toString()).set({
                    'diet': medicineContent.text,
                    'workout': testsContent.text,
                    'advise': commentsContent.text,
                    'adminUid': user,
                    'paitientUid': widget.paitientId.toString(),
                    'ts': DateFormat.yMMMd().format(DateTime.now()),
                  });

                  setState(() {
                    showSnackBar('Submited', context);
                  });

                  medicineContent.clear();
                  testsContent.clear();
                  commentsContent.clear();
                },
                child: const Text('Submit'))
          ],
        ),
        body: kIsWeb
            ? Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Patient name: ${userData['username']}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
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
                                      hintText: 'Advise ',
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
                                      hintText: 'Workout Instruction',
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
                                      hintText: 'Diet plan',
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
                                      hintText: 'Advise',
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
                                      hintText: 'Workout instruction',
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
                                      hintText: 'Diet plan',
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
