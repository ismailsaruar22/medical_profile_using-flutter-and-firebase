import 'package:flutter/material.dart';

class HistoryDetailsPage extends StatelessWidget {
  const HistoryDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: Text('Medical Report'),
          ),
        ),
      ),
    );
  }
}
