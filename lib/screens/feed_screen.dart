import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_profile_v3/doctor/docor_scan_page.dart';
import 'package:medical_profile_v3/profile/profile_update_screen.dart';
import 'package:medical_profile_v3/qr/qr_share_page.dart';
import 'package:medical_profile_v3/screens/homepage.dart';
import 'package:medical_profile_v3/screens/login_screen.dart';

import '../profile/profile.dart';
import 'history_page.dart';

class FeedScreen extends StatefulWidget {
  static const String routeName = '/feed_screen';

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  TabBar get _tabBar => TabBar(
        tabs: [
          Tab(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.home),
                  Text('Home'),
                ],
              ),
            ),
          ),
          Tab(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.history),
                  Text('History'),
                ],
              ),
            ),
          ),
        ],
      );

  TextEditingController prescriptionContent = TextEditingController();
  Uint8List? _image;

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
    return userData['role'] == 'Patient'
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: DefaultTabController(
              length: 2,
              child: Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    // Add your onPressed code here!
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => const QrSharePage(),
                        elevation: 20.0,
                        isScrollControlled: true,
                        backgroundColor: Colors.teal.shade900);
                  },
                  label: const Text('Share'),
                  icon: const Icon(Icons.qr_code),
                  backgroundColor: Colors.pink,
                ),
                appBar: AppBar(
                  backgroundColor: Colors.teal.shade900,
                  title: const Text(
                    'Medical Profile',
                    style: TextStyle(fontSize: 15),
                  ),
                  bottom: PreferredSize(
                    preferredSize: _tabBar.preferredSize,
                    child: ColoredBox(
                      color: Colors.teal.shade900,
                      child: _tabBar,
                    ),
                  ),
                ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        decoration: const BoxDecoration(color: Colors.white),
                        accountName: Container(
                            child: Text(
                          userData['username'].toString(),
                          style: const TextStyle(color: Colors.black),
                        )),
                        accountEmail: Container(
                            child: Text(
                          FirebaseAuth.instance.currentUser!.email.toString(),
                          style: const TextStyle(color: Colors.black),
                        )),
                        currentAccountPicture: Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : CircleAvatar(
                                    radius: 64,
                                    backgroundImage:
                                        NetworkImage(userData['photoUrl']),
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
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Profile();
                          }));
                        },
                        leading: const Icon(Icons.person),
                        title: const Text('Profile'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: const Icon(Icons.history),
                        title: const Text('History'),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const HistoryPage();
                          }));
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProfileUpdateScreen();
                          }));
                        },
                        leading: const Icon(Icons.settings),
                        title: const Text('Update personal info'),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const LoginScreen();
                          }));
                        },
                        title: const Text('Logout'),
                      )
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    HomePage(),
                    HistoryPage(),
                  ],
                ),
              ),
            ),
          )
        : const DoctorScanPage();
  }
}
