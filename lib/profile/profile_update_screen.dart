import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:select_form_field/select_form_field.dart';

class ProfileUpdateScreen extends StatefulWidget {
  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();

  String? gender;
  String? maritalStatus;
  CollectionReference ref = FirebaseFirestore.instance
      .collection('info')
      .doc('user')
      .collection('userInfo');

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _adressController.dispose();
    _ageController.dispose();
    _bloodGroupController.dispose();
    genderController.dispose();
    maritalStatusController.dispose();
  }

  String dropdownValue = 'Male';
  final List<Map<String, dynamic>> _gitems = [
    {
      'label': 'Male',
    },
    {
      'label': 'Female',
    },
    {
      'label': 'Others',
    },
  ];
  final List<Map<String, dynamic>> _mitems = [
    {
      'label': 'Married',
    },
    {
      'label': 'Unmarried',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
            key: _formKey,
            child: Center(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  const Center(child: Text('(Update your profile)')),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.person),
                        hintText: 'Enter your first name',
                        labelText: 'First Name'),
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.person),
                        hintText: 'Enter your last name',
                        labelText: 'Last Name'),
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.phone),
                        hintText: 'Enter a phone number',
                        labelText: 'Phone'),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.email),
                        hintText: 'Enter email adress',
                        labelText: 'Email(Optional)'),
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.calendar_today),
                        hintText: 'Enter your age',
                        labelText: 'Age'),
                  ),
                  TextFormField(
                    controller: _bloodGroupController,
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.bloodtype),
                        hintText: 'Enter your blood group',
                        labelText: 'Blood group(Optional)'),
                  ),
                  TextFormField(
                    controller: _adressController,
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.location_on),
                        hintText: 'Enter your adress',
                        labelText: 'Adress'),
                  ),
                  SelectFormField(
                    controller: genderController,
                    type: SelectFormFieldType.dropdown,
                    labelText: 'Gender',
                    items: _gitems,
                    onChanged: (val) {
                      gender = val;
                    },
                    onSaved: (val) {
                      gender = val;
                    },
                  ),
                  SelectFormField(
                    controller: maritalStatusController,
                    type: SelectFormFieldType.dropdown,
                    labelText: 'Maritual status',
                    items: _mitems,
                    onChanged: (val) {
                      maritalStatus = val;
                    },
                    onSaved: (val) {
                      maritalStatus = val;
                    },
                  ),
                  Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.greenAccent)),
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              ref.add({
                                'fName': _firstNameController.text,
                                'lName': _lastNameController.text,
                                'phone': _phoneController.text,
                                'email': _emailController.text,
                                'age': _ageController.text,
                                'bloodGroup': _bloodGroupController.text,
                                'address': _adressController.text,
                                'gender': genderController.text,
                                'maritalStatus': maritalStatusController.text,
                              });
                              _firstNameController.clear();
                              _lastNameController.clear();
                              _phoneController.clear();
                              _emailController.clear();
                              _ageController.clear();
                              _bloodGroupController.clear();
                              _adressController.clear();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
