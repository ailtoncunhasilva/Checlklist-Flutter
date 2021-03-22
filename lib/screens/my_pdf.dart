import 'dart:typed_data';

import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MyPdf extends StatelessWidget {
  final Checklist checklist;

  MyPdf(this.checklist);

  Future<Uint8List> downloadImg(String url) async {
    Response response;
    try {
      response = await Dio().get<List<int>>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
    } catch (e) {
      print(e);
    }
    if (response == null) {
      return null;
    }
    return response.data;
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document();

    Uint8List temp = await downloadImg('${checklist.photos[0]}');
    PdfImage image = PdfImage.file(pdf.document, bytes: temp);

    Uint8List temp1 = await downloadImg('${checklist.photos[1]}');
    PdfImage image1 = PdfImage.file(pdf.document, bytes: temp1);

    Uint8List temp2 = await downloadImg('${checklist.photos[2]}');
    PdfImage image2 = PdfImage.file(pdf.document, bytes: temp2);

    Uint8List temp3 = await downloadImg('${checklist.photos[3]}');
    PdfImage image3 = PdfImage.file(pdf.document, bytes: temp3);

    Uint8List temp4 = await downloadImg('${checklist.photos[4]}');
    PdfImage image4 = PdfImage.file(pdf.document, bytes: temp4);

    Uint8List temp5 = await downloadImg('${checklist.photos[5]}');
    PdfImage image5 = PdfImage.file(pdf.document, bytes: temp5);

    Uint8List temp6 = await downloadImg('${checklist.photos[6]}');
    PdfImage image6 = PdfImage.file(pdf.document, bytes: temp6);

    Uint8List temp7 = await downloadImg('${checklist.photos[7]}');
    PdfImage image7 = PdfImage.file(pdf.document, bytes: temp7);

    Uint8List temp8 = await downloadImg('${checklist.photos[8]}');
    PdfImage image8 = PdfImage.file(pdf.document, bytes: temp8);

    Uint8List temp9 = await downloadImg('${checklist.photos[9]}');
    PdfImage image9 = PdfImage.file(pdf.document, bytes: temp9);

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(10),
        pageFormat: format,
        build: (context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(6),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _containerForm2(
                    'FORMULÁRIO DE ORDEM DE SERVIÇO(CHECKLIST)  N.OS ${checklist.id}'),
                _containerForm(563, ''),
                _containerForm2('DADOS DO CLIENTE'),
                pw.Row(children: [
                  _containerForm(281.5,
                      'POSSUI CADASTRO CONOSCO: ${checklist.registerList}'),
                  _containerForm(
                      281.5, 'CLIENTE P.F ou P.J: ${checklist.tipClient}')
                ]),
                pw.Row(children: [
                  _containerForm(283, 'CONDUTOR: ${checklist.name}'),
                  _containerForm(140, 'CPF ou CNPJ: ${checklist.cpf}'),
                  _containerForm(140, 'FONE: ${checklist.phone}'),
                ]),
                _containerForm(563, 'ENDEREÇO: ${checklist.address}'),
                _containerForm2('OUTROS DADOS'),
                pw.Row(children: [
                  _containerForm(
                      187.6, 'FORMA DE PAGAMENTO: ${checklist.paymentForm}'),
                  _containerForm(
                      187.6, 'TIPO DE SERVIÇO: ${checklist.typeService}'),
                  _containerForm(187.6,
                      'TIPO DE MANUTENÇÃO: ${checklist.typeMaintenance}'),
                ]),
                pw.Row(children: [
                  _containerForm3(187.6, 'DATA/ENTRADA: ${checklist.dateIn}',
                      ' / ${checklist.hourIn}'),
                  _containerForm3(187.6, 'DATA/SAÍDA: ${checklist.dateOut}',
                      ' / ${checklist.hourOut}'),
                  _containerForm(
                      187.6, 'PREVISÃO DE LIBERAÇÃO: ${checklist.release}'),
                ]),
                _containerForm2('DADOS DO VEÍCULO'),
                pw.Row(children: [
                  _containerForm(
                      187.6, 'TIPO DO VEÍCULO: ${checklist.typeVehicle}'),
                  _containerForm(187.6, 'MARCA/MODELO: ${checklist.marca}'),
                  _containerForm(187.6, 'PLACA ${checklist.placa}'),
                ]),
                pw.Row(children: [
                  _containerForm(140, 'ANO: ${checklist.yearModel}'),
                  _containerForm(140, 'COR: ${checklist.color}'),
                  _containerForm(140, 'KM: ${checklist.km}'),
                  _containerForm(
                      143, 'NIVEL/COMBUSTÍVEL: ${checklist.fuelLevel}'),
                ]),
                pw.Row(children: [
                  _containerForm(187.6, 'FROTA: ${checklist.frota}'),
                  _containerForm(187.6, 'CHASSIS: ${checklist.chassis}'),
                  _containerForm(187.6, 'RENAVAM: ${checklist.renavam}'),
                ]),
                _containerForm2('FOTOS DO VEÍCULO'),
                pw.Container(
                  height: 270,
                  width: double.maxFinite,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1,
                      color: PdfColors.black,
                      style: pw.BorderStyle.solid,
                    ),
                  ),
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(12),
                    child: pw.Column(
                      children: [
                        pw.Row(
                          children: [
                            _containerImage(image),
                            _containerImage(image1),
                            _containerImage(image2),
                            _containerImage(image3),
                          ],
                        ),
                        pw.SizedBox(height: 12),
                        pw.Row(
                          children: [
                            _containerImage(image4),
                            _containerImage(image5),
                            _containerImage(image6),
                            _containerImage(image7),
                          ],
                        ),
                        pw.SizedBox(height: 12),
                        pw.Row(
                          children: [
                            _containerImage(image8),
                            _containerImage(image9),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                _containerForm2('OCORRÊNCIA PARA ORÇAMENTO'),
                pw.Container(
                    height: 50,
                    child: _containerForm(563,
                        'DESCRIÇÃO DOS PROBLEMAS: ${checklist.observation}')),
                _containerForm2('APÓS APROVAÇÃO DO SERVIÇO'),
                pw.Container(
                    height: 50,
                    child: _containerForm(563,
                        'PEÇAS FORNECIDAS PELO CLIENTE: ${checklist.parts}')),
                pw.Container(
                    height: 60,
                    child: _containerForm(
                        563, 'SERVIÇOS EXECUTADOS: ${checklist.parts}')),
                _containerForm(563, 'MECÂNICO: ${checklist.mechanic}'),
                pw.Row(children: [
                  _containerForm3(
                      281.5,
                      'DATA/HORA DO INÍCIO DO SERVIÇO: ${checklist.dateInitService}',
                      ' / ${checklist.hourInitService}'),
                  _containerForm3(
                      281.5,
                      'DATA/HORA DO FIM DO SERVIÇO: ${checklist.dateEndService}',
                      ' / ${checklist.hourEndService}'),
                ]),
                _containerForm(double.maxFinite, 'CLIENTE: '),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  final pw.TextStyle style = pw.TextStyle(
    fontSize: 8,
    color: PdfColors.black,
    //fontWeight: pw.FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('CHECKLIST em PDF'),
          centerTitle: true,
        ),
        body: PdfPreview(
          build: (format) => _generatePdf(format, 'CHECKLIST em PDF'),
        ),
      ),
    );
  }
}

pw.Widget _containerImage(image) {
  return pw.Container(
    height: 70,
    width: 140,
    child: pw.Center(
      child: pw.Image(image),
    ),
  );
}

pw.Widget _signature(String text, double width) {
  return pw.Container(
    height: 25,
    width: width,
    child: pw.Container(
      padding: pw.EdgeInsets.only(left: 2, bottom: 18),
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

pw.Widget _rowItens(String text, String text1, String text2, String text3,
    String text4, String text5) {
  final pw.TextStyle style = pw.TextStyle(
    fontSize: 8,
    color: PdfColors.black,
    //fontWeight: pw.FontWeight.bold,
  );
  return pw.Container(
    height: 84,
    width: 160,
    child: pw.Container(
      padding: pw.EdgeInsets.only(left: 14, top: 14),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(text, style: style),
          pw.Text(text1, style: style),
          pw.Text(text2, style: style),
          pw.Text(text3, style: style),
          pw.Text(text4, style: style),
          pw.Text(text5, style: style),
        ],
      ),
    ),
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

pw.Widget _containerForm2(String text) {
  return pw.Container(
    height: 14,
    width: double.maxFinite,
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

pw.Widget _containerForm3(double width, String text, String text1) {
  return pw.Container(
    height: 14,
    width: width,
    padding: pw.EdgeInsets.only(left: 1, top: 3),
    decoration: pw.BoxDecoration(
      border: pw.Border.all(
        width: 1,
        color: PdfColors.black,
        style: pw.BorderStyle.solid,
      ),
    ),
    child: pw.Row(
      children: [
        pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: 8,
          ),
        ),
        pw.Text(
          text1,
          style: pw.TextStyle(
            fontSize: 8,
          ),
        ),
      ],
    ),
  );
}

pw.Widget _containerTest(String text) {
  return pw.Container(
    height: 14,
    width: double.maxFinite,
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
