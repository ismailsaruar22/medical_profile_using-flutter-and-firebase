import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_profile_v3/utills/color..dart';

import '../lab_admin/pdf_viewer.dart';
import '../resources/firebase_api.dart';

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

  void openPDF(BuildContext context, File file) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PDFViewerPage(file: file);
    }));
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

      // get post lENGTH
      var paitientSnap = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.snap['paitientUid'].toString())
          .get();

      paitientData = paitientSnap.data()!;
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
    // TODO: implement initState
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
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromARGB(255, 224, 231, 233),
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
                child: const Text(
                  'Date: ',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 200,
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
                              "Paitient ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            Text(
                              "Name: ${paitientData['lName'].toString()} ",
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
                              "Sex:  ${paitientData['gender'].toString()} ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: const <Widget>[

                    //       ],
                    //     ),
                    //   ),
                    // )
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
              Text(widget.snap['tests'].toString()),
              const Divider(
                color: Colors.black,
              ),
              const Text(
                "Doctor's comment: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.snap['tests'].toString()),
              const Divider(
                color: Colors.black,
              ),
              TextButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  const url = 'files/vaccine certificate.pdf';
                  const directUrl =
                      'https://firebasestorage.googleapis.com/v0/b/medical-profile-v3.appspot.com/o/files%2Fuser%2FName_Age_Correction_Manual_Applicant.pdf?alt=media&token=9a2353fe-4224-40b7-aac4-1af8b9af60e3';

                  final file = await FirebaseApi.loadFirebase(url);

                  if (file == null) return;
                  openPDF(context, file);
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
              // ElevatedButton(
              //   onPressed: () async {
              //     const url = 'files/vaccine certificate.pdf';
              //     final file = await FirebaseApi.loadFirebase(url);

              //     if (file == null) return;
              //     openPDF(context, file);
              //   },
              //   child: Text('Reports'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
