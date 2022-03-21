// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:medical_profile_v3/prescription/prescription_page.dart';
// import 'package:medical_profile_v3/screens/feed_screen.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users data').doc(FirebaseAuth.instance.currentUser!.email.toString()).collection('profile info').snapshots();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("Loading");
//         }

//         return ListView(
//           children: snapshot.data!.docs.map((DocumentSnapshot document) {
//           Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          
//           }).toList(),
//         );
//       },
//     )
//       ),
//     );
//   }

// }
