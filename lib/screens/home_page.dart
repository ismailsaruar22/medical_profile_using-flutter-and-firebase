import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(40),
            image: DecorationImage(
              image: AssetImage('assets/mask.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Wear a mask -',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black45,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'save lives',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Use proven information about the',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black38,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'disease and take the necessary',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black38,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'preventive measures.',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black38,
              ),
            )
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(40),
            image: DecorationImage(
              image: AssetImage('assets/vaccine.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WHEN IT COMES',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black54,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TO VACCINES DECISION,',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black54,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'THERE IS NO',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black54,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'DILEMMA FOR ME.',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black54,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'VACCINES SAVE LIVES',
              style: TextStyle(
                fontSize: 30,
                color: Colors.lightBlue,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          width: double.infinity,
          height: 150.0,
          color: Colors.teal,
          margin: EdgeInsets.all(25),
          padding: EdgeInsets.all(35),
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(0.1),
          child: Column(
            children: [
              Text(
                '“It is health that is the real wealth, and not pieces of gold and silver.”',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                ' - Mahatma Gandhi',
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
