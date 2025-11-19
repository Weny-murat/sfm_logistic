import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sfm_logistic/blocs/loading_list_cubit/loading_list_cubit.dart';
import 'package:sfm_logistic/data/models/customer.dart';
import 'package:sfm_logistic/data/models/loading_row.dart';
import 'package:sfm_logistic/services/motor_model_list_service.dart';
import 'package:toastification/toastification.dart';



extension MotorModelGetterExt on String {
  String showSnackbar(BuildContext context) {
    return context.read<MotorModelListService>().getModelById(int.parse(this));
  }
}

extension DateFormatter on DateTime {
  String getFormattedDate() {
    var format = DateFormat.yMMMd('tr');
    return format.format(this);
  }
}

extension MotorRequstListExt on List<LoadingRow> {
  List<Map<String, dynamic>> toRequest() {
    List<Map<String, dynamic>> cacheList = [];
    for (var motor in this) {
      cacheList.add({
        'sasiNo': motor.sasiNo,
        'motorNo': motor.motorNo,
        'modelReferansNo': motor.modelReferansNo,
      });
    }
    return cacheList;
  }

  List<LoadingRow> toLoadingList() {
    List<LoadingRow> cacheList = [];
    for (var e in this) {
      cacheList.add(
        LoadingRow(
          sasiNo: e.sasiNo,
          motorNo: e.motorNo,
          modelReferansNo: e.modelReferansNo,
        ),
      );
    }
    return cacheList;
  }
}

extension FormControlExt on FormGroup {
  Map<String, dynamic> getLoadingListDTO(BuildContext context) {
    Map<String, dynamic> rMap = {};
    rMap['firmaId'] = (control("customer").value as Customer).sourceId;
    rMap['tarih'] = DateTime.now().toUtc().toIso8601String();
    rMap['teslimEden'] = control('deliverer').value;
    rMap['teslimAlan'] = control('receiver').value;
    rMap['not'] = control('note').value;
    rMap['isCustom'] = control('isCustom').value;
    rMap['name'] = control('name').value;
    rMap['tc'] = control('tc').value;
    rMap['tel'] = control('tel').value;
    rMap['aracPlaka'] = control('plate').value;
    rMap['yuklenenAraclar'] = context
        .read<LoadingListCubit>()
        .state
        .toRequest();
    return rMap;
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

extension ToastExt on BuildContext {
  void showToast(String message) {
    toastification.dismissAll(delayForAnimation: false);
    toastification.show(
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
      backgroundColor: Theme.of(this).colorScheme.primaryContainer,
      foregroundColor: Theme.of(this).colorScheme.onPrimaryContainer,
      showIcon: false,
    );
  }

  void showErrorToast(String message) {
    toastification.dismissAll(delayForAnimation: false);
    toastification.show(
      description: Text(message),
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
      backgroundColor: Theme.of(this).colorScheme.errorContainer,
      foregroundColor: Theme.of(this).colorScheme.onErrorContainer,
      showIcon: false,
    );
  }
}
