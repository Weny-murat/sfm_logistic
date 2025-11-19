import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sfm_logistic/blocs/loading_lists_cubit/loading_lists_cubit.dart';
import 'package:sfm_logistic/core/utils.dart';
import 'package:sfm_logistic/data/models/data_result.dart';
import 'package:sfm_logistic/data/models/loading_list.dart';
import 'package:sfm_logistic/pages/widgets/detail_container.dart';
import 'package:sfm_logistic/pages/widgets/loading_indicator.dart';
import 'package:sfm_logistic/services/customer_list_service.dart';

class LoadingListsPage extends StatefulWidget {
  const LoadingListsPage({super.key});

  @override
  State<LoadingListsPage> createState() => _LoadingListsPageState();
}

class _LoadingListsPageState extends State<LoadingListsPage> {
  bool isBusy = false;
  double yStart = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (context.read<LoadingListsCubit>().state.isEmpty) {
        log(context.read<LoadingListsCubit>().state.toString());
        await fetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool checkAxis(double start, double end) {
    return ((end - start) > 200);
  }

  Future<void> fetch() async {
    setState(() => isBusy = true);
    final result = await context.read<LoadingListsCubit>().fetchLists();

    switch (result) {
      case Success():
        setState(() => isBusy = false);
      case Failure():
        setState(() => isBusy = false);
        if (context.mounted) {
          context.showErrorToast('Hata:${result.message}');
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yükleme Listeleri')),
      body: SafeArea(
        child: switch (isBusy) {
          true => Center(child: LoadingIndicator()),

          false => BlocBuilder<LoadingListsCubit, List<LoadingList>>(
            builder: (context, state) {
              return RefreshIndicator(
                edgeOffset: 50,
                backgroundColor: Colors.transparent,
                notificationPredicate: (ScrollNotification notification) {
                  if (notification is ScrollStartNotification) {
                    yStart = notification.dragDetails?.globalPosition.dy ?? 0;
                  }
                  if (notification is ScrollEndNotification) {
                    final result = checkAxis(
                      yStart,
                      (notification.dragDetails?.globalPosition.dy ?? 0),
                    );
                    result ? fetch() : null;
                  }
                  return false;
                },
                displacement: 50,
                color: Colors.transparent,
                onRefresh: () => fetch(),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),

                    children: state
                        .map(
                          (e) => Card(
                            key: ValueKey(e.id),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  spacing: 3,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width -
                                              60,
                                          child: Text(
                                            maxLines: 2,
                                            context
                                                .read<CustomerListService>()
                                                .customers
                                                .firstWhere(
                                                  (element) =>
                                                      e.firmaId ==
                                                      element.sourceId,
                                                )
                                                .name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text('Id: ${e.id}'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(e.tarih.getFormattedDate()),
                                        Row(
                                          children: [
                                            Text('Plaka :'),
                                            Text(e.aracPlaka),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${e.yuklenenAraclar.length} Ürün',
                                        ),
                                        Row(
                                          children: [
                                            Text('T.Eden :'),
                                            Text(e.teslimEden),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('T.Alan :'),
                                            Text(
                                              e.teslimAlan == null
                                                  ? e.name != null
                                                        ? e.name!
                                                        : ''
                                                  : e.teslimAlan!,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    DetailContainer(
                                      liste: e,
                                      resfreshFunc: fetch,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            },
          ),
        },
      ),
    );
  }
}
