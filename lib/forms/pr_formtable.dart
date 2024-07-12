import 'package:flutter/material.dart';

class FormPRtable extends StatelessWidget {
  const FormPRtable(
      {super.key, required this.onSave1, required this.fieldName1});
  final void Function(String?)? onSave1;
  final String fieldName1;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: fieldName1,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
      ),
      onSaved: onSave1,
    );
  }
}
