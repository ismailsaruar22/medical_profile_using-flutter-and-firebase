import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_profile_v3/prescription/prescription_page.dart';
import 'package:medical_profile_v3/profile_update_screen.dart';
import 'package:medical_profile_v3/qr/qr_share_page.dart';
import 'package:medical_profile_v3/screens/login_screen.dart';
import 'package:medical_profile_v3/utills/search_page.dart';

import 'history_page.dart';
import 'home_page.dart';

class FeedScreen extends StatefulWidget {
  static final String routeName = '/feed_screen';

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  TabBar get _tabBar => const TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.home),
            text: 'Home',
          ),
          Tab(
            icon: Icon(Icons.history),
            text: 'History',
          ),
        ],
      );

  TextEditingController prescriptionContent = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PrescriptionPage();
                    }));
                  },
                  child: const Text('write prescription'))
            ],
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: ColoredBox(
                color: Colors.blueGrey,
                child: _tabBar,
              ),
            ),
            // actions: [
            //   IconButton(
            //       onPressed: () => Navigator.of(context).push(
            //           MaterialPageRoute(builder: (_) => const SearchPage())),
            //       icon: Icon(Icons.search)),
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
                    'Ismail Sarwar',
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
                const ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notifications'),
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
                  leading: Icon(Icons.settings),
                  title: Text('Update profile info'),
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
          body: const TabBarView(
            children: [
              HomePage(),
              HistoryPage(),
            ],
          ),
        ),
      ),
    );
  }
}
