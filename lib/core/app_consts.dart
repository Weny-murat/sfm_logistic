import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sfm_logistic/data/models/customer.dart';

class CustomTransporterValidator extends Validator<dynamic> {
  final String isCustom;
  final String name;
  final String tc;
  final String tel;

  CustomTransporterValidator({
    required this.isCustom,
    required this.name,
    required this.tc,
    required this.tel,
  }) : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final form = control as FormGroup;

    final isCustomValue = form.control(isCustom).value as bool? ?? false;
    if (!isCustomValue) {
      // custom değilse hiçbir hata yok
      return null;
    }

    final nameValue = (form.control(name).value ?? '').toString().trim();
    final tcValue = (form.control(tc).value ?? '').toString();
    final telValue = (form.control(tel).value ?? '').toString();

    final errors = <String, dynamic>{};

    if (nameValue.isEmpty) {
      errors['nameRequired'] = true;
    }

    final tcReg = RegExp(r'^[0-9]{11}$');
    if (!tcReg.hasMatch(tcValue)) {
      errors['tcInvalid'] = true;
    }

    final telReg = RegExp(
      r'^(?:\+90.?5|0090.?5|905|0?5)(?:[01345][0-9])\s?(?:[0-9]{3})\s?(?:[0-9]{2})\s?(?:[0-9]{2})$',
    );
    if (!telReg.hasMatch(telValue)) {
      errors['telInvalid'] = true;
    }

    return errors.isEmpty ? null : {'customTransporter': errors};
  }
}

class AppConstants {
  static InputDecoration getTextFieldDecoration(
    String label,
    Color color, {
    Widget? suffix,
  }) {
    return InputDecoration(
      suffix: suffix,
      isDense: true,
      isCollapsed: false,
      errorStyle: TextStyle(height: 0, fontSize: 0),
      constraints: const BoxConstraints(minHeight: 85),
      border: OutlineInputBorder(borderSide: BorderSide(color: color)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(5),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(5),
      ),
      labelText: label,
      labelStyle: const TextStyle(overflow: TextOverflow.ellipsis),
    );
  }

  static FormGroup loadingForm = FormGroup(
    {
      'customer': FormControl<Customer>(validators: [Validators.required]),
      'date': FormControl<DateTime>(value: DateTime.now()),
      'plate': FormControl<String>(
        validators: [
          Validators.required,
          Validators.pattern(
            r'^(0[1-9]|[1-7][0-9]|8[01])[ ]?[A-Z]{1,3}[ ]?\d{1,4}$',
          ),
        ],
      ),
      'note': FormControl<String>(),
      'deliverer': FormControl<String>(validators: [Validators.required]),
      'receiver': FormControl<String>(),
      'isCustom': FormControl<bool>(value: false),
      'name': FormControl<String>(),
      'tel': FormControl<String>(),
      'tc': FormControl<String>(),
    },
    validators: [
      CustomTransporterValidator(
        isCustom: 'isCustom',
        name: 'name',
        tc: 'tc',
        tel: 'tel',
      ),
    ],
  );
}
