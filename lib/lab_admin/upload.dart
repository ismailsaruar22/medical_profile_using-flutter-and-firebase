import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medical_profile_v3/lab_admin/pdf_viewer.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../resources/firebase_api.dart';
import '../screens/login_screen.dart';
import '../widgets/button_widgets.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  UploadTask? task;
  File? file;
  void openPDF(BuildContext context, File file) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PDFViewerPage(file: file);
    }));
  }

  bool _isLoading = false;
  var userData = {};

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users data')
          .doc(FirebaseAuth.instance.currentUser!.email.toString())
          .get();

      userData = userSnap.data()!;

      // get post lENGTH

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
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return userData['role'] == 'Admin'
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal.shade900,
              title: const Text('Upload files'),
              centerTitle: true,
              // actions: [
              //   ElevatedButton(
              //       onPressed: () async {
              //         const url = 'files/vaccine certificate.pdf';
              //         final file = await FirebaseApi.loadFirebase(url);
              //
              //         if (file == null) return;
              //         openPDF(context, file);
              //       },
              //       child: Text('View pdf'))
              // ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(color: Colors.white),
                    accountName: Container(
                        child: const Text(
                      'XYZ',
                      style: TextStyle(color: Colors.black),
                    )),
                    accountEmail: Container(
                        child: Text(
                      FirebaseAuth.instance.currentUser!.email.toString(),
                      style: TextStyle(color: Colors.black),
                    )),
                    // currentAccountPicture: Stack(
                    //   children: [
                    //     _image != null
                    //         ? CircleAvatar(
                    //             radius: 64,
                    //             backgroundImage: MemoryImage(_image!),
                    //           )
                    //         : const CircleAvatar(
                    //             radius: 64,
                    //             backgroundImage: NetworkImage(
                    //               'https://thumbs.dreamstime.com/z/businessman-icon-image-male-avatar-profile-vector-glasses-beard-hairstyle-179728610.jpg',
                    //             ),
                    //           ),
                    //     Positioned(
                    //         bottom: -5,
                    //         left: 80,
                    //         child: IconButton(
                    //           icon: const Icon(Icons.add_a_photo),
                    //           color: Colors.teal,
                    //           onPressed: () {},
                    //         ))
                    //   ],
                    // ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // ListTile(
                  //   leading: const Icon(Icons.person),
                  //   title: const Text('Profile'),
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return DoctorProfile();
                  //     }));
                  //   },
                  // ),
                  // ListTile(
                  //   leading: const Icon(Icons.settings),
                  //   title: const Text('Update profile info'),
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return DoctorProfileUpdateScreen();
                  //     }));
                  //   },
                  // ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.logout),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    title: Text('Logout'),
                  )
                ],
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      text: 'Select File',
                      icon: Icons.attach_file,
                      onClicked: selectFile,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      fileName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 48),
                    ButtonWidget(
                      text: 'Upload File',
                      icon: Icons.cloud_upload_outlined,
                      onClicked: uploadFile,
                    ),
                    const SizedBox(height: 20),
                    task != null ? buildUploadStatus(task!) : Container(),
                  ],
                ),
              ),
            ),
          )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.green,
              ),
            ),
          );
  }

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/user/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
