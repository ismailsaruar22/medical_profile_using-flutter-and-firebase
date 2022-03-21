import 'dart:async';
import 'dart:io' show Platform;
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_profile_v3/doctor/doctor_profile.dart';
import 'package:medical_profile_v3/doctor/doctor_profile_update.dart';
import 'package:medical_profile_v3/lab_admin/upload.dart';

import 'package:medical_profile_v3/prescription/prescription_page.dart';
import 'package:medical_profile_v3/screens/paitient_madical_history.dart';
import 'dart:typed_data';
import '../profile/profile.dart';
import '../screens/login_screen.dart';

class DoctorScanPage extends StatefulWidget {
  const DoctorScanPage({Key? key}) : super(key: key);

  @override
  State<DoctorScanPage> createState() => _DoctorScanPageState();
}

class _DoctorScanPageState extends State<DoctorScanPage> {
  ScanResult? scanResult;
  String? paitientId;

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');

  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });

    getData();
  }

  bool _isLoading = false;
  var userData = {};
  Uint8List? _image;
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
  Widget build(BuildContext context) {
    final scanResult = this.scanResult;
    return userData['role'] == 'Doctor'
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal.shade900,
              title: Text('Meidcal Profile'),
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
                    currentAccountPicture: Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                  'https://thumbs.dreamstime.com/z/businessman-icon-image-male-avatar-profile-vector-glasses-beard-hairstyle-179728610.jpg',
                                ),
                              ),
                        Positioned(
                            bottom: -5,
                            left: 80,
                            child: IconButton(
                              icon: const Icon(Icons.add_a_photo),
                              color: Colors.teal,
                              onPressed: () {},
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DoctorProfile();
                      }));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Update profile info'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DoctorProfileUpdateScreen();
                      }));
                    },
                  ),
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
              margin: const EdgeInsets.only(
                left: 5.0,
                right: 5.0,
                top: 5.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Container(
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Text(
                    //   'Share your profile throgh this QR code',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontSize: 17.0,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.teal.shade900,
                    //   ),
                    // ),
                    // QrImage(
                    //   data: FirebaseAuth.instance.currentUser!.email.toString(),
                    //   size: 250,
                    //   // embeddedImage: const AssetImage('images/logo.png'),
                    //   embeddedImageStyle:
                    //       QrEmbeddedImageStyle(size: const Size(80, 80)),
                    // ),
                    // Text(
                    //     'User ID is:  ${FirebaseAuth.instance.currentUser!.email.toString()}'),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.teal.shade900),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return const QrTest();
                        //     },
                        //   ),
                        // );
                        _scan();
                      },
                      child: const Text(
                        'Click here to scan others profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: <Widget>[
                        if (scanResult != null)
                          Card(
                            elevation: 10,
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: const Text(
                                    'Click here to visit paitient profile',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle:
                                      Text('ID: ' + scanResult.rawContent),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return PaitientMedicalHistory(
                                        paitientId: scanResult.rawContent,
                                      );
                                    }));
                                  },
                                  tileColor: Colors.teal.shade900,
                                  textColor: Colors.white,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ListTile(
                                  title: const Text(
                                    'Write prescription to this user',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle:
                                      Text('ID: ' + scanResult.rawContent),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return PrescriptionPage(
                                        paitientId: scanResult.rawContent,
                                      );
                                    }));
                                  },
                                  tileColor: Colors.teal.shade900,
                                  textColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        //if (scanResult == null) Container()
                      ],
                    ),
                  ],
                ),
              ),
            ))
        : UploadPage();
  }

  Future<void> _scan() async {
    try {
      var result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }
}
