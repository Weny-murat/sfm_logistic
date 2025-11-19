import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Widget pdfCell(String value, {double width = 0.8}) {
  final cm = PdfPageFormat.cm;
  return Container(
    width: width * cm,
    height: cm / 2,
    decoration: BoxDecoration(
      border: Border.all(color: PdfColors.black, width: 1),
    ),
    child: Padding(
      padding: EdgeInsets.all(2),
      child: Text(value, style: TextStyle(fontSize: 10)),
    ),
  );
}
