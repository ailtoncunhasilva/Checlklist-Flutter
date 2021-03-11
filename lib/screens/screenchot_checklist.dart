//import 'package:printing/printing.dart';

/*class ScreenshootChecklist extends StatefulWidget {
  static const String id = 'pdf screen';
  final Checklist checklist;

  ScreenshootChecklist(this.checklist);

  @override
  _ScreenshootChecklistState createState() =>
      _ScreenshootChecklistState(checklist);
}

class _ScreenshootChecklistState extends State<ScreenshootChecklist> {
  Checklist checklist;

  _ScreenshootChecklistState(this.checklist);

  pw.Document pdf;
  PdfImage image;
  Uint8List arquivoPdf;

  @override
  void initState() {
    super.initState();
    initPDF();
  }

  Future<void> initPDF() async {
    arquivoPdf = await generarPdf();
  }

  Future<Uint8List> generarPdf() async {
    pdf = pw.Document();

    image = PdfImage.file(pdf.document,
        bytes:
            (await rootBundle.load(checklist.photos[0])).buffer.asUint8List());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (context) {
          return pw.Column(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 20),
                child: pw.Center(
                  child: pw.Text(
                    'PDF',
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  /*pw.Image(
                    image,
                    height: 60,
                    width: 60,
                  ),*/
                ],
              )
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.maxFinite,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: PdfPreview(
                  build: (format) => arquivoPdf,
                  useActions: false,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      arquivoPdf = await generarPdf();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
