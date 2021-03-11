import 'dart:io';

import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:auto_checklist/widget/pdf_preview.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Pdf extends StatelessWidget {
  final Checklist checklist;

  Pdf(this.checklist);

  final pdf = pw.Document();

  writeObPdf() {
    pdf.addPage(
      pw.MultiPage(
        margin: pw.EdgeInsets.all(4),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
              level: 0,
              child: _containerForm(500, checklist.id),
            ),
            _containerPhoto(checklist.photos),
          ];
        },
      ),
    );
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File('$documentPath/example.pdf');

    await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page PDF'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Text('Document PDF'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          writeObPdf();
          await savePdf();

          Directory documentDirectory =
              await getApplicationDocumentsDirectory();

          String documentPath = documentDirectory.path;
          String fullPath = '$documentPath/example.pdf';

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PdfPreviewScreen(fullPath)),
          );
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

pw.Widget _containerPhoto(checklist) {
  return pw.Container(
    height: 60,
    width: 60,
    child: pw.Image(checklist),
  );
}

pw.Widget _containerForm(double width, String text) {
  return pw.Container(
    height: 14,
    width: width,
    child: pw.Container(
      padding: pw.EdgeInsets.only(left: 1, top: 3),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 8,
        ),
      ),
    ),
    decoration: pw.BoxDecoration(
      border: pw.Border.all(
        width: 1,
        color: PdfColors.black,
        style: pw.BorderStyle.solid,
      ),
    ),
  );
}
