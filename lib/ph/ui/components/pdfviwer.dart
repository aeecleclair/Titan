import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class MyPdfViewer extends StatefulWidget {
  final String pdfPath;
  MyPdfViewer({required this.pdfPath});
  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(),
            backgroundColor: Colors.grey,
            body: PdfViewer.openAsset('assets/my_document.pdf')));
  }
}
