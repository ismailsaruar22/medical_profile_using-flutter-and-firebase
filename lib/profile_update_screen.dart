import 'package:flutter/material.dart';

import 'package:select_form_field/select_form_field.dart';

class ProfileUpdateScreen extends StatefulWidget {
  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
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
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.person),
                        hintText: 'Enter your first name',
                        labelText: 'First Name'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.person),
                        hintText: 'Enter your last name',
                        labelText: 'Last Name'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.phone),
                        hintText: 'Enter a phone number',
                        labelText: 'Phone'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.email),
                        hintText: 'Enter email adress',
                        labelText: 'Email(Optional)'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.calendar_today),
                        hintText: 'Enter your age',
                        labelText: 'Age'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.bloodtype),
                        hintText: 'Enter your blood group',
                        labelText: 'Blood group(Optional)'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        //icon: Icon(Icons.location_on),
                        hintText: 'Enter your adress',
                        labelText: 'Adress'),
                  ),
                  SelectFormField(
                    type: SelectFormFieldType.dropdown,
                    initialValue: 'Male',
                    labelText: 'Gender',
                    items: _gitems,
                    onChanged: (val) => print(val),
                    onSaved: (val) => print(val),
                  ),
                  SelectFormField(
                    type: SelectFormFieldType.dropdown,
                    initialValue: 'Married',
                    labelText: 'Maritual status',
                    items: _mitems,
                    onChanged: (val) => print(val),
                    onSaved: (val) => print(val),
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
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {},
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
