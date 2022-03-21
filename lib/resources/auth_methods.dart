import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medical_profile_v3/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final databaseReference = FirebaseDatabase.instance.ref().child("Users");

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
    String textrole = '',
  }) async {
    String res = " Some error occurred";
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              textrole.isNotEmpty
          // file != null
          ) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        databaseReference.child(cred.user!.uid).set({'role': textrole});

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        //add user to our database
        await _firestore
            .collection('users data')
            .doc(cred.user!.email.toString())
            .collection('profile info')
            .doc()
            .set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'photoUrl': photoUrl,
          'role': textrole,
        });

        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // void _addUser(String ID) {
  //   databaseReference.child(ID).set({
  //     'role': textrole,
  //   });
  // }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Something went wrong';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
