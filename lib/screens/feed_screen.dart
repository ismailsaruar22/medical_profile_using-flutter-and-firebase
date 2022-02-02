import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                    'Elizabeth Olsen',
                    style: TextStyle(color: Colors.black),
                  )),
                  accountEmail: Container(
                      child: const Text(
                    'elizabetholsen@gmail.com',
                    style: TextStyle(color: Colors.black),
                  )),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage('photos/ElizabethOlsen.jpg'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.dashboard),
                    onPressed: () {},
                  ),
                  title: const Text('Dashboard'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                  title: const Text('Notifications'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.place),
                    onPressed: () {},
                  ),
                  title: const Text('Branch'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.history),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HistoryPage();
                      }));
                    },
                  ),
                  title: const Text('History'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  title: const Text('Settings'),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {},
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
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
