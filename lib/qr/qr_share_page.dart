import 'dart:async';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_profile_v3/screens/paitient_madical_history.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrSharePage extends StatefulWidget {
  const QrSharePage({Key? key}) : super(key: key);

  @override
  State<QrSharePage> createState() => _QrSharePageState();
}

class _QrSharePageState extends State<QrSharePage> {
  ScanResult? scanResult;
  String? paitientId;

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');

  final _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  final _selectedCamera = -1;
  final _useAutoFocus = true;
  final _autoEnableFlash = false;

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
  }

  @override
  Widget build(BuildContext context) {
    final scanResult = this.scanResult;
    return Container(
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
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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
            Text(
              'Share your profile throgh this QR code',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
            QrImage(
              data: FirebaseAuth.instance.currentUser!.email.toString(),
              size: 250,
              // embeddedImage: const AssetImage('images/logo.png'),
              embeddedImageStyle:
                  QrEmbeddedImageStyle(size: const Size(80, 80)),
            ),
            Text(
                'User ID is:  ${FirebaseAuth.instance.currentUser!.email.toString()}'),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.teal.shade900),
              ),
              onPressed: () {
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
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title:
                              const Text('Click her to visit paitient profile'),
                          subtitle: Text('ID: ' + scanResult.rawContent),
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
                      ],
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
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
