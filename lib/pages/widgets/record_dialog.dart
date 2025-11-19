import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sfm_logistic/blocs/loading_list_cubit/loading_list_cubit.dart';
import 'package:sfm_logistic/core/utils.dart';
import 'package:sfm_logistic/data/models/chassis_info.dart';
import 'package:sfm_logistic/data/models/data_result.dart';
import 'package:sfm_logistic/pages/widgets/loading_indicator.dart';
import 'package:sfm_logistic/services/rest_api_service.dart';

class RecordDialog extends StatefulWidget {
  const RecordDialog({super.key});

  @override
  State<RecordDialog> createState() => _RecordDialogState();
}

class _RecordDialogState extends State<RecordDialog> {
  FocusNode chassisFocusNode = FocusNode();
  FocusNode motorFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      FocusScope.of(context).requestFocus(chassisFocusNode);
    });
  }

  ChassisInfo? chassis;
  bool isDirty = false;
  bool isBusy = false;
  final checkForm = FormGroup({
    'chassis': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(17),
        Validators.maxLength(17),
      ],
    ),
    'motor': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: checkForm,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Şasi No', style: TextStyle(fontSize: 24))],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReactiveTextField(
                    focusNode: chassisFocusNode,
                    onChanged: (control) {
                      if (control.value != null) {
                        isDirty = true;
                        control.value = (control.value as String).toUpperCase();
                      }
                    },
                    formControlName: 'chassis',
                    maxLength: 17,

                    onEditingComplete: (_) {
                      FocusScope.of(context).requestFocus(motorFocusNode);
                      setState(() {
                        isDirty = true;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Motor No', style: TextStyle(fontSize: 24)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReactiveTextField(
                    focusNode: motorFocusNode,
                    formControlName: 'motor',
                    onChanged: (control) {
                      if (control.value != null) {
                        isDirty = true;
                        control.value = (control.value as String).toUpperCase();
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton(
                        onPressed: context.pop,
                        child: Text('Kapat'),
                      ),
                      FilledButton(
                        onPressed: () {
                          checkForm.reset();
                          FocusScope.of(context).requestFocus(chassisFocusNode);
                        },
                        child: Text('Sıfırla'),
                      ),
                      ReactiveFormConsumer(
                        builder: (context, form, child) {
                          return FilledButton(
                            onPressed: form.valid
                                ? () async {
                                    final formChassis =
                                        form.value['chassis'] as String;
                                    final formMotor =
                                        form.value['motor'] as String;
                                    chassis = null;
                                    for (var chs
                                        in context
                                            .read<LoadingListCubit>()
                                            .state) {
                                      if (chs.sasiNo == formChassis) {
                                        context.showErrorToast(
                                          'Bu Şasi zaten yükleme listesinde kayıtlı.',
                                        );
                                        return;
                                      }
                                    }
                                    setState(() => isBusy = true);

                                    final result = await context
                                        .read<RestApiService>()
                                        .checkChassis(formChassis, formMotor);

                                    switch (result) {
                                      case Success<ChassisInfo>():
                                        chassis = result.data;
                                        log(chassis!.transactions.toString());
                                        log(
                                          chassis!.transactions.length
                                              .toString(),
                                        );
                                        log(
                                          chassis!.transactions.first
                                              .toString(),
                                        );
                                        log(
                                          chassis!.transactions.last.toString(),
                                        );
                                        setState(() {
                                          isDirty = false;
                                          if (chassis!.rowInfo.motorNo ==
                                              form.value['motor'] as String) {
                                            if (chassis!
                                                    .transactions
                                                    .last
                                                    .remamount ==
                                                0) {
                                              context.showErrorToast(
                                                'Mükerrer Kayıt.\nLütfen muhasebe birimi ile iletişime geçin.',
                                              );
                                            } else if (chassis!
                                                    .transactions
                                                    .last
                                                    .remamount ==
                                                1) {
                                              context
                                                  .read<LoadingListCubit>()
                                                  .add(chassis!.rowInfo);
                                              checkForm.reset();
                                              context.showToast('Eklendi.');

                                              FocusScope.of(
                                                context,
                                              ).requestFocus(chassisFocusNode);
                                            }
                                          } else {
                                            context.showToast(
                                              'Şasi numarası ve motor numarası logodaki ile uyuşmuyor.',
                                            );
                                          }
                                        });
                                      case Failure<ChassisInfo>():
                                        if (context.mounted) {
                                          context.showErrorToast(
                                            'Teknik hata.${result.message}',
                                          );
                                        }
                                    }
                                    setState(() => isBusy = false);
                                  }
                                : null,
                            child: Text(' Ekle '),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          isBusy
              ? Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainer.withValues(alpha: 0.8),
                    ),

                    child: const Center(child: LoadingIndicator()),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
