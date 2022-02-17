import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medical_profile_v3/respnsiveness/mobile_screen_layout.dart';
import 'package:medical_profile_v3/respnsiveness/responsive_layout_screen.dart';
import 'package:medical_profile_v3/respnsiveness/websreen_layout.dart';
import 'package:medical_profile_v3/screens/feed_screen.dart';
import 'package:medical_profile_v3/screens/login_screen.dart';
import 'package:medical_profile_v3/screens/sign_up_screen.dart';
import 'package:medical_profile_v3/utills/color..dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyATdFgFkEAXpIcMzAqUSahhUWmKcquIFF0",
          appId: "1:819362576544:web:ee37718788643c371731c5",
          messagingSenderId: "819362576544",
          projectId: "medical-profile-v3",
          storageBucket: 'medical-profile-v3.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return FeedScreen();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
