import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class Pdf extends StatefulWidget {
  String url;
  Pdf({Key? key, required this.url}) : super(key: key);
  @override
  _PdfState createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  String? pdfFlePath;

  Future<String> downloadAndSavePdf() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/sample.pdf');
    if (await file.exists()) {
      return file.path;
    }
    final response = await http.get(Uri.parse(widget.url));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  bool _isLoading = true;

  void loadPdf() async {
    pdfFlePath = await downloadAndSavePdf();
    setState(() {});
    _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.teal.shade900,
            title: const Text('Reports'),
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    if (pdfFlePath != null)
                      Expanded(
                        child: Container(
                          child: PdfView(
                            path: pdfFlePath!,
                          ),
                        ),
                      )
                    else
                      const Text("Pdf is not Loaded"),
                  ],
                ),
        );
      }),
    );
  }
}
