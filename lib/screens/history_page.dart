import 'package:flutter/material.dart';
import 'history_details_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<String> entries = <String>['A', 'B', 'C'];

  void navigateToHistoryDetailsPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HistoryDetailsPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: navigateToHistoryDetailsPage,
          child: Container(
            height: 50,
            color: Colors.grey,
            child: Center(child: Text('Entry ${entries[index]}')),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
