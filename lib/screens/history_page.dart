import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'details_page.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Prescription '),
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
            margin: EdgeInsets.all(20),
            child: ListView(
              children: snapshot.data!.docs.map((appointments) {
                // return Container(
                //   child: Center(child: Text(notes['content'])),
                // );
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailsPage();
                    }));
                  },
                  child: Card(
                    elevation: 30,
                    child: ListTile(
                      title: Text(appointments.id),
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