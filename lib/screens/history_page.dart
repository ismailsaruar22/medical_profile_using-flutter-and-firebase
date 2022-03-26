import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_profile_v3/utills/color..dart';
import 'package:medical_profile_v3/widgets/prescription_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final ref = FirebaseFirestore.instance.collection('appointments');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            .doc(FirebaseAuth.instance.currentUser!.email.toString())
            .collection('appoinments')
            .orderBy('ts', descending: true)
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
