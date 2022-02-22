import 'package:flutter/material.dart';
import 'package:medical_profile_v3/profile/profile_update_screen.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //for circle avtar image
          _getHeader(),
          const SizedBox(
            height: 10,
          ),
          _profileName("Test Khan"),
          const SizedBox(
            height: 14,
          ),
          _heading("Personal Details"),
          const SizedBox(
            height: 6,
          ),
          _detailsCard(),
          const SizedBox(
            height: 10,
          ),
          _heading("Settings"),
          const SizedBox(
            height: 6,
          ),
          _settingsCard(),
          const Spacer(),
        ],
      )),
    );
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(10.0)),
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80"))
                // color: Colors.orange[100],
                ),
          ),
        ),
      ],
    );
  }

  Widget _profileName(String name) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80, //80% of width,
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Text(
        heading,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _detailsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: const [
            //row for each deatails
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Something@gmail.com"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("1234567890"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.bloodtype),
              title: Text("Blood Group : B+"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.people_alt_outlined),
              title: Text("Married"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.timelapse),
              title: Text("24 Years old"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Dhaka, Bangladesh"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each deatails
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Update Profile Info"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfileUpdateScreen();
                }));
              },
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
