import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sfm_logistic/core/utils.dart';
import 'package:sfm_logistic/data/models/customer.dart';
import 'package:sfm_logistic/data/models/loading_list.dart';
import 'package:sfm_logistic/pages/widgets/pdf_widgets/pdf_cell.dart';
import 'package:sfm_logistic/pages/widgets/pdf_widgets/pdf_watermark.dart';
import 'package:sfm_logistic/services/motor_model_list_service.dart';

class PdfData {
  final Uint8List bytes;
  final String fileName;

  PdfData(this.bytes, this.fileName);
}

class PdfService {
  final MotorModelListService motorModelListService;

  PdfService({required this.motorModelListService});

  // İlk sayfa için maksimum ürün (başlık ve müşteri bilgileri var)
  static const int firstPageItems = 44;
  // Diğer sayfalar için maksimum ürün (sadece tablo var)
  static const int otherPagesItems = 50;

  static Future<Document> addRecord({
    required Document document,
    required LoadingList list,
    required Customer? customer,
  }) async {
    final cm = PdfPageFormat.cm;
    final image = (await rootBundle.load(
      'assets/images/logo.png',
    )).buffer.asUint8List();

    final headerImage = (await rootBundle.load(
      'assets/images/footer.png',
    )).buffer.asUint8List();

    final titleStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
    final normalStyle = TextStyle(fontSize: 9);

    // Ürünleri grupla ve renderList'i hazırla
    var sortedList = list.yuklenenAraclar.toList()
      ..sort((a, b) => a.modelReferansNo.compareTo(b.modelReferansNo));

    Map<String, int> countList = {};
    for (var e in sortedList) {
      countList[e.modelReferansNo] = (countList[e.modelReferansNo] ?? 0) + 1;
    }

    Set<String> addedHeaders = {};
    List<Widget> allItems = [];

    for (int i = 0; i < sortedList.length; i++) {
      var e = sortedList[i];

      if (!addedHeaders.contains(e.modelReferansNo)) {
        addedHeaders.add(e.modelReferansNo);
        allItems.add(
          Container(
            color: PdfColors.grey100,
            // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: Row(
              children: [
                pdfCell(
                  '${MotorModelListService.instance.getModelById(int.parse(e.modelReferansNo))} - ${countList[e.modelReferansNo]} Adet',
                  width: 19.40,
                ),
              ],
            ),
          ),
        );
      }

      allItems.add(
        Container(
          child: Row(
            children: [
              pdfCell('${i + 1}', width: 1),
              pdfCell('', width: 3),
              pdfCell(
                MotorModelListService.instance.getModelById(
                  int.parse(e.modelReferansNo),
                ),
                width: 6.4,
              ),
              pdfCell(e.sasiNo, width: 4),
              pdfCell(e.motorNo, width: 5),
            ],
          ),
        ),
      );
    }

    // Toplam sayfa sayısını hesapla
    int totalPages = 1;
    int remainingItems = allItems.length;

    if (remainingItems > firstPageItems) {
      remainingItems -= firstPageItems;
      totalPages += (remainingItems / otherPagesItems).ceil();
    }

    // Sayfalara böl
    int currentIndex = 0;

    for (int pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      final isFirstPage = pageIndex == 0;
      final isLastPage = pageIndex == totalPages - 1;
      final currentPage = pageIndex + 1;

      final itemsForThisPage = isFirstPage ? firstPageItems : otherPagesItems;
      final endIndex = (currentIndex + itemsForThisPage).clamp(
        0,
        allItems.length,
      );
      final pageItems = allItems.sublist(currentIndex, endIndex);
      currentIndex = endIndex;

      document.addPage(
        Page(
          pageFormat: PdfPageFormat.a4,
          margin: EdgeInsets.only(
            left: 0.8 * cm,
            top: 0.8 * cm,
            right: 0.8 * cm,
            bottom: 0.8 * cm,
          ),
          build: (context) {
            return Stack(
              children: [
                pdfWatermark(image),
                Column(
                  children: [
                    // Başlık - sadece ilk sayfada
                    if (isFirstPage)
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 4.5 * cm,
                              height: 1 * cm,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: MemoryImage(headerImage),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Text(
                              'YÜKLEME LİSTESİ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 4.5 * cm,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'NO: ${list.id}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Tarih: ${list.tarih.getFormattedDate()}',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Müşteri ve Araç Bilgileri - sadece ilk sayfada
                    if (isFirstPage)
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    customer?.name ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    customer?.address1 ?? '',
                                    style: normalStyle,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    customer?.tel1 ?? '',
                                    style: normalStyle,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '${customer?.city ?? ''} / ${customer?.country ?? ''}',
                                    style: normalStyle,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            SizedBox(
                              width: 4.5 * cm,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ARAÇ VE ŞOFÖR BİLGİLERİ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'PLAKA: ${list.aracPlaka}',
                                    style: normalStyle,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'ŞOFÖR: ${list.teslimAlan == null
                                        ? list.name != null
                                              ? list.name!
                                              : ''
                                        : list.teslimAlan!}',
                                    style: normalStyle,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'T.C.: ${list.tc ?? ''}',
                                    style: normalStyle,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'TEL: ${list.tel ?? ''}',
                                    style: normalStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Tablo başlığı - her sayfada
                    Container(
                      color: PdfColors.grey200,

                      child: Row(
                        children: [
                          pdfCell('No', width: 1),
                          pdfCell('', width: 3),
                          pdfCell('Model ve Renk', width: 6.4),
                          pdfCell('Şasi No.', width: 4),
                          pdfCell('Motor No', width: 5),
                        ],
                      ),
                    ),

                    // Bu sayfanın ürünleri
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: pageItems,
                      ),
                    ),

                    // Toplam ve Not - sadece son sayfada
                    if (isLastPage) ...[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: PdfColors.grey200, width: 1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Toplam: ${list.yuklenenAraclar.length} Adet Ürün',
                              style: titleStyle,
                            ),
                            SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Not: ', style: titleStyle),
                                Expanded(
                                  child: Text(
                                    list.not ?? '',
                                    style: normalStyle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text('TESLİM EDEN', style: titleStyle),
                              SizedBox(height: 4),
                              Container(
                                width: 5 * cm,
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1)),
                                ),
                                child: Center(
                                  child: Text(
                                    list.teslimEden,
                                    style: titleStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('TESLİM ALAN', style: titleStyle),
                              SizedBox(height: 4),
                              Container(
                                width: 5 * cm,
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1)),
                                ),
                                child: Center(
                                  child: Text(
                                    list.teslimAlan == null
                                        ? list.name != null
                                              ? list.name!
                                              : ''
                                        : list.teslimAlan!,
                                    style: titleStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: 1.5 * cm),
                    // Sayfa numarası - her sayfada
                    Container(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        'Sayfa $currentPage / $totalPages',
                        style: TextStyle(fontSize: 8, color: PdfColors.grey600),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    }

    return document;
  }

  Future<PdfData> generatePdf({
    required LoadingList loadingList,
    required Customer? customer,
  }) async {
    final myTheme = ThemeData.withFont(
      base: Font.ttf(await rootBundle.load('assets/fonts/calibri-regular.ttf')),
      bold: Font.ttf(await rootBundle.load('assets/fonts/calibri-bold.ttf')),
      italic: Font.ttf(
        await rootBundle.load('assets/fonts/calibri-italic.ttf'),
      ),
      boldItalic: Font.ttf(
        await rootBundle.load('assets/fonts/calibri-bold-italic.ttf'),
      ),
    );
    Document pdf = Document(theme: myTheme, author: 'Murat ALANYURT');
    pdf = await addRecord(document: pdf, list: loadingList, customer: customer);

    return PdfData(await pdf.save(), '${loadingList.id}');
  }
}
