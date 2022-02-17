import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final ref = FirebaseFirestore.instance.collection('notes');
  String data = '';

  void getData() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('notes').doc().get();
    setState(() {
      data = (snap.data() as Map<String, dynamic>)['content'];
    });
  }

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
              children: snapshot.data!.docs.map((notes) {
                return Container(
                  child: Center(child: Text(notes['content'])),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
