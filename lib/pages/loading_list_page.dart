import 'dart:developer';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sfm_logistic/blocs/list_edit_bloc/list_edit_bloc.dart';
import 'package:sfm_logistic/blocs/list_edit_bloc/list_edit_event.dart';
import 'package:sfm_logistic/blocs/list_edit_bloc/list_edit_state.dart';
import 'package:sfm_logistic/blocs/loading_list_cubit/loading_list_cubit.dart';
import 'package:sfm_logistic/core/app_consts.dart';
import 'package:sfm_logistic/core/utils.dart';
import 'package:sfm_logistic/data/models/data_result.dart';
import 'package:sfm_logistic/data/models/loading_row.dart';
import 'package:sfm_logistic/pages/widgets/first_step.dart';
import 'package:sfm_logistic/pages/widgets/loading_indicator.dart';
import 'package:sfm_logistic/pages/widgets/record_dialog.dart';
import 'package:sfm_logistic/pages/widgets/second_step.dart';
import 'package:sfm_logistic/services/customer_list_service.dart';
import 'package:sfm_logistic/services/rest_api_service.dart';

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({super.key});

  @override
  State<LoadingListPage> createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  bool isLoading = false;
  int currentIndex = 0;

  late final FormGroup form;

  @override
  void initState() {
    super.initState();

    form = FormGroup({
      'isCustom': FormControl<bool>(value: false),
      'name': FormControl<String>(),
      'tc': FormControl<String>(),
      'tel': FormControl<String>(),
    });

    // isCustom değişince validator’ları değiştir
    final isCustomControl = form.control('isCustom');
    final nameControl = form.control('name');
    final tcControl = form.control('tc');
    final telControl = form.control('tel');

    isCustomControl.valueChanges.listen((isCustomValue) {
      if (isCustomValue == true) {
        nameControl.setValidators([Validators.required]);

        telControl.setValidators([
          Validators.pattern(
            r'^(?:\+90.?5|0090.?5|905|0?5)(?:[01345][0-9])\s?(?:[0-9]{3})\s?(?:[0-9]{2})\s?(?:[0-9]{2})$',
          ),
        ]);

        tcControl.setValidators([
          Validators.number(allowNegatives: false, allowNull: false),
          Validators.minLength(11),
          Validators.maxLength(11),
        ]);
      } else {
        nameControl.setValidators([]);
        tcControl.setValidators([]);
        telControl.setValidators([]);

        // önceki hataları temizlemek için:
        nameControl.setErrors({});
        tcControl.setErrors({});
        telControl.setErrors({});
      }

      // burada `updateValueAndValidity()` çağırmak artık güvenli,
      // çünkü validator içinde değil
      nameControl.updateValueAndValidity();
      tcControl.updateValueAndValidity();
      telControl.updateValueAndValidity();
    });
  }

  Future<void> saveList() async {
    final result = await context.read<RestApiService>().saveLoadingList(
      AppConstants.loadingForm.getLoadingListDTO(context),
    );
    switch (result) {
      case Success():
        if (context.mounted) {
          context.showToast('Kaydedildi.');
          context.read<LoadingListCubit>().removeAll();
          AppConstants.loadingForm.reset(value: {'tarih': DateTime.now()});
          setState(() {
            currentIndex = 0;
            isLoading = false;
          });
        }
      case Failure():
        if (context.mounted) {
          context.showErrorToast('Hata:${result.message}');
          setState(() => isLoading = false);
        }
    }
  }

  Future<void> updateList(int id) async {
    final result = await context.read<RestApiService>().updateLoadingList(
      id,
      AppConstants.loadingForm.getLoadingListDTO(context),
    );
    switch (result) {
      case Success():
        if (context.mounted) {
          context.showToast('Güncellendi.');
          context.read<LoadingListCubit>().removeAll();
          context.read<ListEditBloc>().add(ListEditFinished());
          AppConstants.loadingForm.reset(value: {'tarih': DateTime.now()});
          setState(() {
            currentIndex = 0;
            isLoading = false;
          });
        }
      case Failure():
        if (context.mounted) {
          context.showErrorToast('Hata:${result.message}');
        }
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: AppConstants.loadingForm,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Yükleme Listesi'),
          actions: [
            BlocBuilder<ListEditBloc, ListEditState>(
              builder: (context, state) {
                return state is ListEditing
                    ? TextButton(
                        onPressed: () {
                          context.read<ListEditBloc>().add(ListEditFinished());
                        },
                        child: Text('Güncellemeden Çık'),
                      )
                    : SizedBox.shrink();
              },
            ),
          ],
        ),
        body: isLoading
            ? Center(child: LoadingIndicator())
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EasyStepper(
                    activeStep: currentIndex,
                    activeStepTextColor: Colors.black87,
                    finishedStepTextColor: Colors.black87,
                    internalPadding: 0,
                    showLoadingAnimation: false,
                    finishedStepBackgroundColor: Colors.green,
                    steps: [
                      EasyStep(
                        icon: Icon(Icons.fire_truck),
                        activeIcon: Icon(Icons.fire_truck),
                        finishIcon: Icon(Icons.fire_truck),
                        customTitle: const Text(
                          'Sevk Bilgileri',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      EasyStep(
                        icon: Icon(Icons.edit_document),
                        customTitle: const Text(
                          'Motor Listesi',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    onStepReached: (index) => currentIndex,
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: currentIndex,
                      children: [
                        FirstStep(
                          customerList: context
                              .read<CustomerListService>()
                              .customers,
                        ),
                        SecondStep(),
                      ],
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            child: IconButton(
                              onPressed: currentIndex == 0
                                  ? null
                                  : () => setState(() => currentIndex -= 1),
                              icon: Icon(Icons.arrow_back),
                            ),
                          ),

                          CircleAvatar(
                            child: currentIndex == 0
                                ? ReactiveFormConsumer(
                                    builder: (context, form, child) {
                                      return IconButton(
                                        onPressed: () async {
                                          final selection = await showDialog(
                                            context: context,

                                            builder: (e) => AlertDialog(
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      context.pop(false),
                                                  child: Text('Vazgeç'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      context.pop(true),
                                                  child: Text('Onayla'),
                                                ),
                                              ],
                                              title: Text(
                                                'Liste sıfırlanacak onaylıyor musunuz?',
                                              ),
                                            ),
                                          );
                                          if (selection == true) {
                                            form.reset(
                                              value: {'date': DateTime.now()},
                                            );
                                          }
                                        },
                                        icon: Icon(Icons.delete),
                                      );
                                    },
                                  )
                                : BlocBuilder<
                                    LoadingListCubit,
                                    List<LoadingRow>
                                  >(
                                    builder: (context, state) {
                                      return IconButton(
                                        onPressed: state.isNotEmpty
                                            ? () async {
                                                final selection = await showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            context.pop(false),
                                                        child: Text('Vazgeç'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            context.pop(true),
                                                        child: Text('Onayla'),
                                                      ),
                                                    ],
                                                    title: Text(
                                                      'Motor listesi sıfırlanacak onaylıyor musunuz?',
                                                    ),
                                                  ),
                                                );
                                                if (selection == true) {
                                                  context
                                                      .read<LoadingListCubit>()
                                                      .removeAll();
                                                }
                                              }
                                            : null,
                                        icon: Icon(Icons.delete),
                                      );
                                    },
                                  ),
                          ),
                          currentIndex == 1
                              ? CircleAvatar(
                                  child: IconButton(
                                    onPressed: () => showModalBottomSheet(
                                      isScrollControlled: true,
                                      isDismissible: false,
                                      context: context,
                                      builder: (context) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(
                                            context,
                                          ).viewInsets.bottom,
                                        ),
                                        child: RecordDialog(),
                                      ),
                                    ),
                                    icon: Icon(Icons.add),
                                  ),
                                )
                              : CircleAvatar(
                                  child: ReactiveCheckbox(
                                    formControlName: 'isCustom',
                                  ),
                                ),
                          ReactiveFormConsumer(
                            builder: (context, form, child) {
                              return BlocBuilder<
                                LoadingListCubit,
                                List<LoadingRow>
                              >(
                                builder: (context, state) {
                                  log(state.isNotEmpty.toString());
                                  log(currentIndex.toString());
                                  log(form.valid.toString());
                                  return CircleAvatar(
                                    child: IconButton(
                                      onPressed: currentIndex < 1
                                          ? () =>
                                                setState(() => currentIndex = 1)
                                          : form.valid &&
                                                currentIndex == 1 &&
                                                state.isNotEmpty
                                          ? () async {
                                              final currentState = context
                                                  .read<ListEditBloc>()
                                                  .state;

                                              switch (currentState) {
                                                case ListEditing():
                                                  final selection = await showDialog(
                                                    context: context,
                                                    builder: (e) => AlertDialog(
                                                      title: Text(
                                                        'Güncelleme yapılacak emin misiniz?',
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              context.pop(
                                                                false,
                                                              ),
                                                          child: Text('Vazgeç'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () =>
                                                              context.pop(true),
                                                          child: Text('Onayla'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                  if (selection) {
                                                    setState(
                                                      () => isLoading = true,
                                                    );
                                                    await updateList(
                                                      (currentState).list.id,
                                                    );
                                                  }
                                                default:
                                                  await saveList();
                                              }
                                            }
                                          : null,
                                      icon: Icon(
                                        currentIndex == 1
                                            ? Icons.save
                                            : Icons.arrow_forward,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
