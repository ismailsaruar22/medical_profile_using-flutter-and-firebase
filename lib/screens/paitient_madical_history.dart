import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_profile_v3/utills/color..dart';
import 'package:medical_profile_v3/widgets/prescription_card.dart';

class PaitientMedicalHistory extends StatefulWidget {
  String paitientId;
  PaitientMedicalHistory({Key? key, required this.paitientId})
      : super(key: key);

  @override
  _PaitientMedicalHistoryState createState() => _PaitientMedicalHistoryState();
}

class _PaitientMedicalHistoryState extends State<PaitientMedicalHistory> {
  // File? file;
  // void openPDF(BuildContext context, File file) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return PDFViewerPage(file: file);
  //   }));
  // }

  final ref = FirebaseFirestore.instance.collection('appointments');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.teal.shade700,
        //   title: const Text(
        //     'Prescriptions ',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(color: primaryColor),
        //   ),
        // ),
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
        SliverAppBar(
          backgroundColor: Colors.teal.shade700,
          floating: true,
          snap: true,
          title: const Text(
            "Prescriptions",
            style: TextStyle(color: primaryColor),
          ),
        ),
      ],
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users data')
            .doc(widget.paitientId.toString())
            .collection('appoinments')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 31, 124, 34),
                backgroundColor: Colors.grey,
                strokeWidth: 10,
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              child: PrescriptionCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    ));
  }
}
