import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_profile_v3/lab_admin/upload.dart';
import 'package:medical_profile_v3/resources/auth_methods.dart';
import 'package:medical_profile_v3/screens/feed_screen.dart';
import 'package:medical_profile_v3/screens/sign_up_screen.dart';
import 'package:medical_profile_v3/utills/color..dart';
import 'package:medical_profile_v3/utills/utils.dart';
import 'package:medical_profile_v3/widgets/textfield_input.dart';

import '../doctor/doctor_login_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res == 'success') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FeedScreen()));
      setState(() {
        _isLoading = false;
      });
    } else {
      showSnackBar('Please enter email and password correctly', context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  navigateToSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploadPage()),
              );
            },
            child: const Text(
              'Upload report',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                SvgPicture.asset(
                  'assets/icons8-remind-app.svg',
                  height: 100,
                ),
                const Text(
                  'Medical Profile',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextfieldInput(
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                  hintText: 'Enter Your email',
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextfieldInput(
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  hintText: 'Enter your password',
                  isPass: true,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                InkWell(
                  onTap: loginUser,
                  child: Container(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text(
                            'Log In',
                          ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        color: Colors.teal),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Are you a doctor?"),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(5)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.teal),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const DoctorLoginPage();
                          }));
                        },
                        child: const Text(
                          'Login as a doctor',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("dont you have an account?"),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                    ),
                    InkWell(
                      onTap: navigateToSignUp,
                      child: Container(
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                )
                //bla blal bal
              ],
            )),
      ),
    );
  }
}
