import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sfm_logistic/blocs/list_edit_bloc/list_edit_bloc.dart';
import 'package:sfm_logistic/blocs/list_edit_bloc/list_edit_event.dart';
import 'package:sfm_logistic/blocs/loading_lists_cubit/loading_lists_cubit.dart';
import 'package:sfm_logistic/blocs/pdf_bloc/pdf_bloc.dart';
import 'package:sfm_logistic/core/utils.dart';
import 'package:sfm_logistic/data/models/data_result.dart';
import 'package:sfm_logistic/data/models/loading_list.dart';
import 'package:sfm_logistic/pages/widgets/show_grid.dart';
import 'package:sfm_logistic/services/customer_list_service.dart';
import 'package:sfm_logistic/services/rest_api_service.dart';

class DetailContainer extends StatefulWidget {
  final Function resfreshFunc;
  final LoadingList liste;
  const DetailContainer({
    super.key,
    required this.liste,
    required this.resfreshFunc,
  });

  @override
  State<DetailContainer> createState() => _DetailContainerState();
}

class _DetailContainerState extends State<DetailContainer> {
  bool isExtended = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AnimatedContainer(
      duration: Durations.medium1,
      height: isExtended ? (widget.liste.yuklenenAraclar.length + 1) * 80 : 40,
      child: isExtended
          ? Stack(
              children: [
                ShowGrid(chassisList: widget.liste.yuklenenAraclar),
                Positioned(
                  top: 2,
                  left: 2,
                  child: Material(
                    child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      width: size.width - 30,
                      height: 52,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final result = await context
                                    .read<RestApiService>()
                                    .deleteLoadingList(widget.liste.id);
                                switch (result) {
                                  case Success():
                                    context.showErrorToast('Silindi.');
                                    widget.resfreshFunc();
                                  case Failure():
                                    context.showErrorToast(result.message);
                                }
                              },
                              child: Text(
                                'Sil',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                            Platform.isWindows
                                ? widget.liste.frozen == true
                                      ? ElevatedButton(
                                          onPressed: () async {
                                            final result = await context
                                                .read<RestApiService>()
                                                .unArchiveLoadingList(
                                                  widget.liste,
                                                );
                                            switch (result) {
                                              case Success():
                                                context
                                                    .read<LoadingListsCubit>()
                                                    .fetchLists();
                                              case Failure():
                                                context.showErrorToast(
                                                  'Arşivden çıkarılamadı. ${result.message}',
                                                );
                                            }
                                          },
                                          child: Text('Arşiv den çıkar'),
                                        )
                                      : ElevatedButton(
                                          onPressed: () async {
                                            final result = await context
                                                .read<RestApiService>()
                                                .archiveLoadingList(
                                                  widget.liste,
                                                );
                                            switch (result) {
                                              case Success():
                                                context
                                                    .read<LoadingListsCubit>()
                                                    .fetchLists();
                                              case Failure():
                                                context.showErrorToast(
                                                  'Arşivlenemedi. ${result.message}',
                                                );
                                            }
                                          },
                                          child: Text('Arşivle'),
                                        )
                                : SizedBox(),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ListEditBloc>().add(
                                  ListEditStarted(list: widget.liste),
                                );
                              },
                              child: Text('Düzenle'),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  setState(() => isExtended = false),
                              child: Text('Kapat'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(
                      Platform.isAndroid ? Icons.preview : Icons.print,
                    ),
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsetsGeometry.all(8),
                      ),
                    ),
                    onPressed: () async {
                      final bloc = context.read<PdfBloc>();

                      // Event gönder
                      bloc.add(
                        CreatePdf(
                          customer: context
                              .read<CustomerListService>()
                              .getCustomerById(widget.liste.firmaId),

                          list: widget.liste,

                          // list: LoadingList(
                          //   id: 3,
                          //   firmaId: 3,
                          //   tarih: "2025-10-27T09:27:48.640914",
                          //   teslimEden: 'MAHMUT',
                          //   teslimAlan: 'MURAT',
                          //   not: 'not',
                          //   aracPlaka: '68 SFM 741',
                          //   yuklenenAraclar: [
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //     LoadingRow(
                          //       sasiNo: 'sasiNo',
                          //       motorNo: 'motorNo',
                          //       modelReferansNo: '7455',
                          //     ),
                          //   ],
                          // ),
                        ),
                      );

                      // State değişikliğini bekle (PdfCreating veya PdfCreated olana kadar)
                      await bloc.stream.firstWhere(
                        (state) =>
                            state is PdfCreating ||
                            state is PdfCreated ||
                            state is PdfCreationFailed,
                      );

                      // Dialog'u aç
                      if (!context.mounted) return;

                      showDialog(
                        context: context,
                        builder: (dialogContext) => BlocProvider.value(
                          value: bloc,
                          child: Dialog(
                            child: AspectRatio(
                              aspectRatio: 21 / 32,
                              child: BlocBuilder<PdfBloc, PdfState>(
                                builder: (context, state) {
                                  switch (state) {
                                    case PdfInitial():
                                      return PdfPreview(
                                        canChangePageFormat: false,
                                        initialPageFormat: PdfPageFormat.a4,
                                        previewPageMargin: EdgeInsets.all(8),
                                        canChangeOrientation: false,
                                        allowPrinting: false,
                                        allowSharing: false,
                                        canDebug: false,
                                        build: (format) {
                                          final pdf = pw.Document();
                                          pdf.addPage(
                                            pw.Page(
                                              pageFormat: PdfPageFormat.a4,
                                              build: (context) => pw.Center(
                                                child: pw.Text(
                                                  widget.liste.aracPlaka,
                                                ),
                                              ),
                                            ),
                                          );
                                          return pdf.save();
                                        },
                                      );
                                    case PdfCreating():
                                      return Center(
                                        child: Text('Pdf oluşturuluyor'),
                                      );
                                    case PdfCreated():
                                      return PdfPreview(
                                        initialPageFormat: PdfPageFormat.a4,
                                        actions: Platform.isAndroid
                                            ? []
                                            : [
                                                IconButton(
                                                  onPressed: () async =>
                                                      await Printing.layoutPdf(
                                                        onLayout: (format) =>
                                                            state.data.bytes,
                                                      ),
                                                  icon: Icon(Icons.print),
                                                ),
                                              ],
                                        canChangePageFormat: false,
                                        allowPrinting: false,
                                        previewPageMargin: EdgeInsets.all(8),
                                        canChangeOrientation: false,
                                        canDebug: false,
                                        allowSharing: Platform.isAndroid
                                            ? false
                                            : true,
                                        dynamicLayout: false,
                                        build: (format) => state.data.bytes,
                                      );
                                    case PdfCreationFailed():
                                      return Center(
                                        child: Text(
                                          'Pdf oluşturulurken hata oluştu. Lütfen tekrar deneyin.',
                                        ),
                                      );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    label: Text(Platform.isAndroid ? 'Önizleme' : 'Yazdır'),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.search),
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsetsGeometry.all(8),
                      ),
                    ),
                    onPressed: () => setState(() => isExtended = !isExtended),
                    label: Text('Detaylar'),
                  ),
                ],
              ),
            ),
    );
  }
}
