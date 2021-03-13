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
                    'DEV-DOCUMENTO DE ENTRADA DE VEÍCULOS(CHECKLIST)'),
                pw.Row(children: [
                  _containerForm(281.50, 'ENTRADA DO VEÍCULO: ___/___/_____'),
                  _containerForm(281.50, 'PREVISÃO DE ENTREGA: ___/___/_____'),
                ]),
                pw.Row(children: [
                  _containerForm(281.50, 'PPLACA: ${checklist.placa}'),
                  _containerForm(281.50, 'N.OS: ${checklist.id}'),
                ]),
                _containerForm2('DADOS DO CLIENTE'),
                pw.Row(children: [
                  _containerForm(400, 'NOME: ${checklist.name}'),
                  _containerForm(163, 'CPF: ${checklist.cpf}')
                ]),
                pw.Row(children: [
                  _containerForm(281.50, 'FONE/WHATSAPP: ${checklist.phone}'),
                  _containerForm(281.50, 'E-MAIL: ${checklist.email}')
                ]),
                _containerForm2('DADOS DO VEÍCULO'),
                pw.Row(children: [
                  _containerForm(263, 'MARCA/MODELO: ${checklist.marca}'),
                  _containerForm(150, 'ANO: ${checklist.yearModel}'),
                  _containerForm(
                      150, 'TIPO COMBUSTÍVEL: ${checklist.combustivel}'),
                ]),
                _containerForm(563, 'CHASSIS: ${checklist.chassis}'),
                pw.Container(
                  height: 14,
                  width: double.maxFinite,
                  child: pw.Container(
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
                        pw.Text('  (   )AR ', style: style),
                        pw.Text(' (   )ALARME ', style: style),
                        pw.Text(' (   )DH.CÂMBIO ', style: style),
                        pw.Text(' (   )AUTOMÁTICO ', style: style),
                        pw.Text(' (   )AUTOMATIZADO ', style: style),
                        pw.Text(' (   )CVT ', style: style),
                        pw.Text(' (   )MANUAL ', style: style),
                        pw.Text(' (   )ABS ', style: style),
                        pw.Text(' (   )AIR BAG ', style: style),
                        pw.Text(' (   )4X2 ', style: style),
                        pw.Text(' (   )4X4 ', style: style),
                      ],
                    ),
                  ),
                ),
                pw.Container(
                  height: 90,
                  width: double.maxFinite,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1,
                      color: PdfColors.black,
                      style: pw.BorderStyle.solid,
                    ),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      _rowItens(
                        '(   )ESTEPE',
                        '(   )MACACO',
                        '(   )CHAVE DE RODA',
                        '(   )TRIÂNGULO',
                        '(   )ANTENA',
                        '(   )VIDRO ELÉTRICO',
                      ),
                      _rowItens(
                        '(   )TRAVA ELÉTRICA',
                        '(   )CALOTAS/RODAS DE LIGA',
                        '(   )PÁRA BRISA TRINCADO',
                        '(   )RÁDIO/MULTIMÍDIA',
                        '(   )ALARME/CORTA CORRENTE',
                        '(   )EXTINTOR',
                      ),
                      _rowItens(
                        '(   )DOCUMENTO',
                        '(   )BUZINA',
                        '(   )PROTETOR DE CÁRTER',
                        '(   )CHAVE SEGREDO(RODA)',
                        '(   )TAPETES',
                        '(   )ACENDEDOR/TOMADA 12V',
                      ),
                    ],
                  ),
                ),
                _containerForm2('FOTOS DO VEÍCULO'),
                pw.Container(
                  height: 180,
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
                      ],
                    ),
                  ),
                ),
                _containerForm2(
                    'SERVIÇOS SOLICITADOS(INSPEÇÃO/MANUTENÇÃO/REPARAÇÃO'),
                _containerForm(double.maxFinite, ''),
                _containerForm(double.maxFinite, ''),
                _containerForm(double.maxFinite, ''),
                _containerForm(double.maxFinite, ''),
                _containerForm(double.maxFinite, 'OBS.:'),
                _containerForm(double.maxFinite, ''),
                _containerForm2('CONDIÇÕES GERAIS'),
                pw.Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1,
                      color: PdfColors.black,
                      style: pw.BorderStyle.solid,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text(
                        ' 1.Para serviços de sinistro contratados pela seguradores, o cliente está ciente que as peças necessárias para total reparação'
                        'do veículo serão fornecidas pela seguradora e que, portanto, os serviços apenas serão iniciados quando as peças forem'
                        'entregues.(para oficinas que trabalhem com seguradoras)\n 2.O cliente autoriza, se necessário, a saída do veículo para execução'
                        'de testes fora das instalações da oficina, ficando ciente que, em caso de acidente, a responsabilidade da Empresa Reparadora'
                        'estará limitada a danos causados em razão do sinistro.\n 3.O cliente está ciente e concorda que esta Empresa Reparadora cobrará'
                        'pelos serviços de diagnóstico que realizar, no valor até _____horas técnicas. Valor da hora técnica: R\$______,00'
                        '(__________________)reais.\n 4.O cliente autoriza o portador abaixo qualificado a assinar o presente DEV e a retirar seu'
                        'veículo, quando da entrega do mesmo reparado.(Quando a pessoa não é a mesma qualificada no documento CRLV do veículo)',
                        maxLines: null,
                        style: pw.TextStyle(
                          fontSize: 6,
                        ),
                      ),
                      pw.Center(
                        child: pw.Text(
                          'A OFICINA NÃO SE RESPONSABILIZA POR OBJETOS DEIXADOS DENTRO DO VEÍCULO(SOLICITE SACOLA PLÁSTICA)',
                          style: pw.TextStyle(
                            fontSize: 6,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _containerForm(
                    double.maxFinite,
                    'CONFIRMO QUE O VEÍCULO ENCONTRA-SE NAS CONDIÇÕES AQUI APRESENTADOS.'
                    'SOBRE AS QUAIS AFIRMO TER SIDO PREVIAMENTE INFORMADO(A).'),
                _containerForm2('ASSINATURAS'),
                pw.Row(
                  children: [
                    _signature('RESPONSÁVEL PELO PREENCHIMENTO', 200),
                    _signature(
                        ' (  )CLIENTE  (  )GUINCHEIRO  (  )PORTEIRO  (  )MOTORISTA',
                        250),
                    _signature('RG', 113),
                  ],
                ),
              ],
            ),
          );
          /*pw.Column(
            children: [
              pw.Container(
                child: pw.Text(checklist.id),
              ),
              pw.Row(
                children: [
                  pw.Container(
                    height: 80,
                    width: 70,
                    child: pw.Center(
                      child: pw.Image(image),
                    ),
                  ),
                  pw.Container(
                    height: 80,
                    width: 70,
                    child: pw.Center(
                      child: pw.Image(image1),
                    ),
                  ),
                ],
              ),
            ],
          );*/
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
