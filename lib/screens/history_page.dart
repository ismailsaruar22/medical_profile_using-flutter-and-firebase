import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../lab_admin/pdf_viewer.dart';
import '../resources/firebase_api.dart';
import 'details_page.dart';
import 'package:path/path.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  File? file;
  void openPDF(BuildContext context, File file) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PDFViewerPage(file: file);
    }));
  }

  final ref = FirebaseFirestore.instance.collection('appointments');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Prescription '),
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            margin: const EdgeInsets.all(20),
            child: ListView(
              children: snapshot.data!.docs.map((appointments) {
                // return Container(
                //   child: Center(child: Text(notes['content'])),
                // );
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const DetailsPage();
                    }));
                  },
                  child: Card(
                    elevation: 30,
                    child: ListTile(
                      onTap: () async {
                        const url = 'files/vaccine certificate.pdf';
                        final file = await FirebaseApi.loadFirebase(url);

                        if (file == null) return;
                        openPDF(context, file);
                      },
                      title: const Text('Date and time'),
                      tileColor: Colors.blue.shade500,
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
