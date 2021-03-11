//import 'package:printing/printing.dart';


/*class GeneratePDF {
  Checklist checklist;

  GeneratePDF(this.checklist);

  generatePDF() async {
    final pw.Document doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(margin: pw.EdgeInsets.zero),
        //header: _buildHeader,
        header: _buildContent,
      ),
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat pageFormat) async => doc.save(),
    );
  }

  pw.Widget _buildContent(pw.Context context) {
    return pw.Column(
      children: [
        pw.Text(checklist.id),
        pw.Text(checklist.name),
        pw.Text(checklist.cpf),
        pw.Text(checklist.email),
        pw.SizedBox(height: 16),
      ],
    );
  }
}*/
