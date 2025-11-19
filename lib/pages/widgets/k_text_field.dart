import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sfm_logistic/core/app_consts.dart';

class KTextField extends StatefulWidget {
  const KTextField({
    super.key,
    required this.size,
    required this.formControlName,
    required this.label,
    this.lines,
    this.readOnly = false,
  });

  final Size size;
  final String formControlName;
  final String label;
  final int? lines;
  final bool readOnly;

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  TextEditingController? controller;
  final focusNode = FocusNode();
  final GlobalKey textKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.lines == null ? 45 : widget.lines! * 30,
      width: widget.size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: ReactiveTextField(
          key: textKey,
          readOnly: widget.readOnly,
          formControlName: widget.formControlName,
          controller: controller,
          focusNode: focusNode,
          maxLines: widget.lines,
          showErrors: (control) => true,
          decoration: AppConstants.getTextFieldDecoration(
            widget.label,
            Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
