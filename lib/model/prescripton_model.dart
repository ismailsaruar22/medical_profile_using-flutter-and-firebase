import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String tests;
  final String paitienId;
  final String comments;
  final String medicine;
  final String postId;
  final DateTime datePublished;
  final String doctorId;

  const Post({
    required this.comments,
    required this.datePublished,
    required this.doctorId,
    required this.medicine,
    required this.paitienId,
    required this.postId,
    required this.tests,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        medicine: snapshot['medicine'],
        comments: snapshot['comments'],
        tests: snapshot['tests'],
        paitienId: snapshot['paitientId'],
        doctorId: snapshot['doctorId'],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"]);
  }

  Map<String, dynamic> toJson() => {
        "medicine": medicine,
        "comments": comments,
        "tests": tests,
        "postId": postId,
        "datePublished": datePublished,
        "paitientId": paitienId,
        "doctorId": doctorId
      };
}
