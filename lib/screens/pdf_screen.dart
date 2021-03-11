import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:pdf/pdf.dart';
import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfScreen extends StatefulWidget {
  final Checklist checklist;

  PdfScreen(this.checklist);

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gerar PDF'),
          centerTitle: true,
        ),
        body: PdfPreview(
          build: (format) => _generatePdf(format),
        ),
      ),
    );
  }

  Future<List<int>> getImageToBytes() async {
    Response<List<int>> response = await Dio().get<List<int>>(
        '${widget.checklist.photos[0]}',
        options: Options(responseType: ResponseType.bytes));

    return response.data;
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    Future _networkImageToByte(String url) async {
      ImageProvider image = NetworkImage(url);
      Uint8List byteImage = await networkImageToByte(url);
      return byteImage;
    }

    Uint8List temp = await _networkImageToByte('${widget.checklist.photos[0]}');

    final photoChecklist = LabelPDFCreatorForProduct(
      baseColor: PdfColors.lightGreen600,
      accentColor: PdfColors.lightGreen100,
      photoURL: temp,
    );
    await photoChecklist.buildPdf();

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(6),
        pageFormat: format,
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
                _containerForm2(500, 'DADOS DO CLIENTE'),
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
              ],
            ),
          );
        },
      ),
    );
    return pdf.save();
  }

  pdfImageConverter(Uint8List photoURL, pw.Document doc) {
    PdfImage images = PdfImage.file(doc.document, bytes: photoURL);
    return pw.Container(
      alignment: pw.Alignment.center,
      //child: pw.Image(images),
    );
  }
}

// ignore: non_constant_identifier_names
LabelPDFCreatorForProduct(
    {PdfColor baseColor, PdfColor accentColor, Uint8List photoURL}) {
  return LabelPDFCreatorForProduct(
    baseColor: baseColor,
    accentColor: accentColor,
    photoURL: photoURL,
  );
}

pw.Widget _photoContainer(PdfImage image) {
  return pw.Container(
    height: 70,
    width: 60,
    child: pw.Image(image),
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
