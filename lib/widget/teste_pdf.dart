import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;

class PdfScreen2 extends StatefulWidget {
  final Checklist checklist;

  PdfScreen2(this.checklist);

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen2> {
  Uint8List imageData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Gerar PDF'),
            centerTitle: true,
          ),
          body: FlatButton(
            child: Text("Teste"),
            onPressed: () async {
              var path =
                  await _generatePdf();

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PdfViewerPage(path: path), 
                ),
              );
            },
          )),
    );
  }

  Future<String> getResult({String path}) async {
    var response = await http.get(
      "$path",
    );
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.bodyBytes),
        quality: 60,
        name: "temp${DateTime.now().millisecondsSinceEpoch}");
    if (result["isSuccess"]) {
      return result["filePath"].toString().replaceAll("file:///", "");
    } else {
      return "erro";
    }
  }

  Future<String> _generatePdf() async {
    final pw.Document pdf = pw.Document(deflate: zlib.encode);
    String path2 = "";
    try {
      path2 = await getResult(
          path:
              "${widget.checklist.photos[0]}");
    } on PlatformException catch (error) {
      if (error is PlatformException) {
        return "erro";
      }
    }

    final image = PdfImage.file(
      pdf.document,
      bytes: File(path2).readAsBytesSync(),
    );

    
    String path = "";
    final String dir = (await getApplicationDocumentsDirectory()).path; 

    path = '$dir/temp.pdf';


    final File file = File(path);

    await file.writeAsBytes(pdf
        .save()); 

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4, 
        build: (context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(6),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _containerForm2(
                    500, 'DEV-DOCUMENTO DE ENTRADA DE VEÍCULOS(CHECKLIST)'),
                pw.Row(children: [
                  _containerForm(234.90, 'ENTRADA DO VEÍCULO: ___/___/_____'),
                  _containerForm(234.90, 'PREVISÃO DE ENTREGA: ___/___/_____'),
                ]),
                pw.Row(children: [
                  _containerForm(234.90, 'PPLACA: ${widget.checklist.placa}'),
                  _containerForm(234.90, 'N.OS: ${widget.checklist.id}'),
                ]),
                _containerForm2(
                    500, 'DADOS DO CLIENTE'), 
                pw.Row(children: [
                  _containerForm(300, 'NOME: ${widget.checklist.name}'),
                  _containerForm(169.80, 'CPF: ${widget.checklist.cpf}')
                ]),
                pw.Row(children: [
                  _containerForm(
                      234.90, 'FONE/WHATSAPP: ${widget.checklist.phone}'),
                  _containerForm(234.90, 'E-MAIL: ${widget.checklist.email}')
                ]),
                _containerForm2(500, 'DADOS DO VEÍCULO'),
                pw.Row(children: [
                  _containerForm(
                      169.80, 'MARCA/MODELO: ${widget.checklist.marca}'),
                  _containerForm(150, 'ANO: ${widget.checklist.yearModel}'),
                  _containerForm(
                      150, 'TIPO COMBUSTÍVEL: ${widget.checklist.combustivel}'),
                ]),
                _containerForm(500, 'CHASSIS: ${widget.checklist.chassis}'),
                pw.Container(
                  height: 60,
                  width: 60,
                  decoration:
                      pw.BoxDecoration(image: pw.DecorationImage(image: image)),
                ),

              ],
            ),
          );
        },
      ),
    );
    return path;
  }
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

pw.Widget _containerForm2(double width, String text) {
  return pw.Container(
    height: 14,
    width: width,
    child: pw.Center(
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: 8,
          color: PdfColors.white,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    ),
    decoration: pw.BoxDecoration(
      color: PdfColors.black,
      border: pw.Border.all(
        width: 1,
        color: PdfColors.black,
        style: pw.BorderStyle.solid,
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget PdfViewerPage({String path}) {
  return PDFViewerScaffold(
    path: path,
    appBar: AppBar(
      centerTitle:
          true, 
      title: Text("OS - "),
    ),
  );
}
