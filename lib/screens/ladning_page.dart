import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          color: Colors.teal.shade900,
        ),
        Container(
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
            //borderRadius: BorderRadius.circular(40),
            image: DecorationImage(
              image: const AssetImage('assets/mask.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
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
          children: const [
            Text(
              'save lives',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
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
          children: const [
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
          children: const [
            Text(
              'preventive measures.',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black38,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
            //borderRadius: BorderRadius.circular(40),
            image: DecorationImage(
              image: AssetImage('assets/vaccine.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
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
          children: const [
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
          children: const [
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
          children: const [
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
          children: const [
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
        const SizedBox(
          height: 40,
        ),
        Container(
          width: double.infinity,
          height: 150.0,
          color: Colors.teal,
          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(35),
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(0.1),
          child: Column(
            children: const [
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
    ;
  }
}
