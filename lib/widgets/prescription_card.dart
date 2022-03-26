import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_profile_v3/lab_admin/pdf_view.dart';
import 'package:medical_profile_v3/lab_admin/upload.dart';
import 'package:medical_profile_v3/utills/color..dart';

class PrescriptionCard extends StatefulWidget {
  final snap;
  const PrescriptionCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PrescriptionCard> createState() => _PrescriptionCardState();
}

class _PrescriptionCardState extends State<PrescriptionCard> {
  File? file;
  bool _isLoading = false;
  var userData = {};
  var paitientData = {};
  var roleData = {};
  var urlData = {};

  getInfo() async {
    var photoUrlSnap = await FirebaseFirestore.instance
        .collection('Doctor')
        .doc(widget.snap['paitientUid'])
        .collection('appoinments')
        .doc(widget.snap['postId'])
        .get();

    urlData = photoUrlSnap.data()!;
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('Doctor')
          .doc(widget.snap['doctorUid'])
          .get();

      userData = userSnap.data()!;

      var paitientSnap = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.snap['paitientUid'].toString())
          .get();

      paitientData = paitientSnap.data()!;

      var userRoleSnap = await FirebaseFirestore.instance
          .collection('users data')
          .doc(FirebaseAuth.instance.currentUser!.email.toString())
          .get();

      roleData = userRoleSnap.data()!;
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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black38,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: const Color.fromARGB(255, 224, 231, 233),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey[500],
                child: Text(
                  'Date: ${widget.snap['ts']}',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 220,
                width: double.infinity,
                color: Colors.grey[400],
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Prescription ID: ${widget.snap['postId']}'),
                            const Text(
                              'Doctor ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            Text(
                              'Name: ${userData['lName'].toString()}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            Text(
                              "ID:  ${userData['doctor id'].toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            Text(
                              "Speciality:  ${userData['speciality'].toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Patient ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            Text(
                              "Name: ${paitientData['fName'].toString()} ${paitientData['lName'].toString()} ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            Text(
                              "Age: ${paitientData['age'].toString()}  ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            Text(
                              "Gender:  ${paitientData['gender'].toString()} ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.green,
                thickness: 5,
              ),
              const Text(
                "Tests: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.snap['tests'].toString(),
              ),
              const Divider(
                color: Colors.black,
              ),
              const Text(
                'Medicine: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.snap['medicine'].toString()),
              const Divider(
                color: Colors.black,
              ),
              const Text(
                "Doctor's comment: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.snap['comments'].toString()),
              const Divider(
                color: Colors.black,
              ),
              roleData['role'] == 'Admin'
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UploadPage(
                                  docId: widget.snap['postId'].toString(),
                                  paitientId:
                                      widget.snap['paitientUid'].toString(),
                                );
                              },
                            ),
                          );
                        });
                      },
                      child: const Text('Upload Report'))
                  : TextButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Pdf(url: widget.snap['reportUrl'].toString());
                        }));

                        setState(() {
                          _isLoading = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.teal.shade700,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                  backgroundColor: Colors.grey,
                                ),
                              )
                            : const Text(
                                "Reports",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        width: 80,
                        height: 40,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
