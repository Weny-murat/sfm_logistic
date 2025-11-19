import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Widget pdfWatermark(Uint8List image) {
  final cm = PdfPageFormat.cm;
  return Positioned(
    left: 0.5 * cm,
    child: Opacity(
      opacity: 0.03,
      child: Container(
        width: 17.5 * cm,
        height: 20 * cm,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(image),
            fit: BoxFit.contain,
          ),
        ),
      ),
    ),
  );
}
