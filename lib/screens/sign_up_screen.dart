import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_profile_v3/resources/auth_methods.dart';

import 'package:medical_profile_v3/screens/feed_screen.dart';
import 'package:medical_profile_v3/screens/login_screen.dart';
import 'package:medical_profile_v3/utills/color..dart';
import 'package:medical_profile_v3/utills/utils.dart';
import 'package:medical_profile_v3/widgets/textfield_input.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  String textrole = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!,
        textrole: textrole);
    setState(() {
      _isLoading = false;
    });

    if (res != "success") {
      showSnackBar(res, context);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FeedScreen()));
    }
  }

  navigateToSignIn() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade900,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Medical Profile',
                  style: TextStyle(
                    fontSize: 44.0,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Stack(
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
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                          color: Colors.teal,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextfieldInput(
                  textInputType: TextInputType.text,
                  textEditingController: _usernameController,
                  hintText: 'Enter Your Name',
                ),
                const SizedBox(
                  height: 20.0,
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
                  height: 20.0,
                ),

                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Role',
                  ),
                  value: textrole.isNotEmpty ? textrole : null,
                  items: <String>['Patient', 'Doctor', 'Admin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      textrole = value.toString();
                    });
                  },
                ),

                const SizedBox(
                  height: 24.0,
                ),
                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text(
                            'Sign up',
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Already have an account?"),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                    ),
                    InkWell(
                      onTap: navigateToSignIn,
                      child: Container(
                        child: const Text(
                          "Sign In",
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
            ),
          ),
        ),
      ),
    );
  }
}
